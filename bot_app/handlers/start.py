from aiogram.filters import Command
from aiogram.types import Message
from aiogram.utils.i18n import gettext as _

from bot_app import markup
from bot_app.misc import main_router
from local_extensions import db_methods

# TODO would be great run it before commit
# black bot_app local_extensions
# isort bot_app local_extensions
# mypy bot_app local_extensions


@main_router.message(Command(commands=["start"]))
async def start_command(message: Message):
    user_data = await db_methods.tg_user.get(message.from_user)
    if user_data is not None:
        await message.answer(_("You are in the main menu"))
        return
    user_data = await db_methods.tg_user.new(message.from_user)
    await message.answer(
        _("Please select the language"),
        reply_markup=markup.base.main_bot_language_keyboard(user_data.locale),
    )


# Start for not using locale example

# @main_router.message(Command(commands=["start"]))
# async def start_command(message: Message):
#     user_data = await db_methods.tg_user.get(message.from_user)
#     if user_data is None:
#         await db_methods.tg_user.new(message.from_user)
#     await message.answer('You are in the main menu')
