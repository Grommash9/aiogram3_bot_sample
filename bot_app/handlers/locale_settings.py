from aiogram import Bot, F
from aiogram.filters import Command, CommandObject
from aiogram.types import BotCommand, CallbackQuery, Message
from aiogram.types.bot_command_scope_chat import BotCommandScopeChat
from aiogram.utils.i18n import gettext as _

from bot_app import markup, misc
from bot_app.markup.base import LanguageCallback
from bot_app.misc import main_router
from local_extensions import db_methods


@main_router.message(Command(commands=["language"]))
async def start_echo_command(message: Message, command: CommandObject) -> None:
    user_data = await db_methods.tg_user.get(message.from_user)
    assert user_data is not None
    await message.answer(
        _("Please select the language"),
        reply_markup=markup.base.main_bot_language_keyboard(user_data.locale),
    )


@main_router.callback_query(LanguageCallback.filter(F.action == "update"))
async def update_locale(call: CallbackQuery, callback_data: LanguageCallback, bot: Bot) -> None:
    assert callback_data.new_language is not None
    await misc.update_locale(call.from_user, callback_data.new_language)
    bot_commands = [
        BotCommand(
            command="/language",
            description=_("Change language", locale=callback_data.new_language),
        )
    ]
    await bot.set_my_commands(
        commands=bot_commands, scope=BotCommandScopeChat(chat_id=call.message.chat.id)
    )
    await call.answer()
    await call.message.delete()
    await bot.send_message(
        call.message.chat.id,
        _("The language is successfully installed!", locale=callback_data.new_language),
    )


@main_router.callback_query(LanguageCallback.filter(F.action == "cancel"))
async def cancel_locale_update(call: CallbackQuery) -> None:
    await call.answer()
    await call.message.delete()
