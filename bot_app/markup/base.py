from typing import Optional

from aiogram.filters.callback_data import CallbackData
from aiogram.utils.i18n import gettext as _
from aiogram.utils.keyboard import InlineKeyboardBuilder


class LanguageCallback(CallbackData, prefix = "mother_bot_locale"):
    action: str
    new_language: Optional[str]


def main_bot_language_keyboard(user_locale):
    m = InlineKeyboardBuilder()
    m.button(
        text="🇺🇲 English",
        callback_data=LanguageCallback(action="update", new_language="en").pack(),
    )
    m.button(
        text="🇺🇦 Українська",
        callback_data=LanguageCallback(action="update", new_language="uk").pack(),
    )
    m.button(
        text="🇪🇸 Español",
        callback_data=LanguageCallback(action="update", new_language="es").pack(),
    )
    m.button(
        text=_("❌ Cancel", locale=user_locale),
        callback_data=LanguageCallback(action="cancel", new_language=None).pack(),
    )
    return m.adjust(2, 3).as_markup()
