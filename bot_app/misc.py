from typing import Any, Dict

import redis.asyncio as aioredis
from aiogram import Bot, Dispatcher, Router
from aiogram.client.session.aiohttp import AiohttpSession
from aiogram.fsm.storage.redis import DefaultKeyBuilder, RedisStorage
from aiogram.types import TelegramObject, User
from aiogram.utils.i18n import I18n
from aiogram.utils.i18n.middleware import I18nMiddleware
from aiogram.webhook.aiohttp_server import SimpleRequestHandler
from aiohttp import web

from bot_app import config
from bot_app.config import I18N_DOMAIN
from local_extensions import db_methods

redis = aioredis.Redis(decode_responses=True)


async def on_startup(dispatcher: Dispatcher):
    await bot.set_webhook(f"{config.BASE_URL}{config.MAIN_BOT_PATH}")


class MyI18nLocale(I18nMiddleware):
    async def get_locale(self, event: TelegramObject, data: Dict[str, Any]) -> str:
        user: User = data["event_from_user"]
        cached_locale = await redis.hget(I18N_DOMAIN, user.id)
        if cached_locale is not None:
            return cached_locale

        user_data = await db_methods.tg_user.get(user)
        if user_data is not None and user_data.locale is not None:
            await redis.hset(I18N_DOMAIN, str(user.id), user_data.locale)
            return user_data.locale
        return "en"


async def update_locale(user: User, new_locale: str):
    await db_methods.tg_user.update_locale(user, new_locale)
    await redis.hset(I18N_DOMAIN, str(user.id), new_locale)


current_i18n = I18n(
    path="bot_app/locales", default_locale="en", domain=f"{I18N_DOMAIN}"
)

my_locale = MyI18nLocale(current_i18n)
main_router = Router()

my_locale.setup(main_router)

session = AiohttpSession()
bot_settings = {"session": session, "parse_mode": "HTML"}
bot = Bot(token=config.MAIN_BOT_TOKEN, **bot_settings)
storage = RedisStorage.from_url(
    config.REDIS_DSN, key_builder=DefaultKeyBuilder(with_bot_id=True)
)
main_dispatcher = Dispatcher(storage=storage)
main_dispatcher.include_router(main_router)
main_dispatcher.startup.register(on_startup)
app = web.Application()
routes = web.RouteTableDef()

SimpleRequestHandler(dispatcher=main_dispatcher, bot=bot).register(
    app, path=config.MAIN_BOT_PATH
)
