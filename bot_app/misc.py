from bot_app.handlers.base import main_router
from aiohttp import web
from bot_app import config
from aiogram import Bot, Dispatcher
from aiogram.client.session.aiohttp import AiohttpSession
from aiogram.fsm.storage.redis import DefaultKeyBuilder, RedisStorage
from aiogram.webhook.aiohttp_server import (
    SimpleRequestHandler,
)

async def on_startup(dispatcher: Dispatcher, bot: Bot):
    await bot.set_webhook(f"{config.BASE_URL}{config.MAIN_BOT_PATH}")


session = AiohttpSession()
bot_settings = {"session": session, "parse_mode": "HTML"}
bot = Bot(token=config.MAIN_BOT_TOKEN, **bot_settings)
storage = RedisStorage.from_url(config.REDIS_DSN, key_builder=DefaultKeyBuilder(with_bot_id=True))

main_dispatcher = Dispatcher(storage=storage)
main_dispatcher.include_router(main_router)
main_dispatcher.startup.register(on_startup)


app = web.Application()
routes = web.RouteTableDef()

SimpleRequestHandler(dispatcher=main_dispatcher, bot=bot).register(app, path=config.MAIN_BOT_PATH)


