If you don't want to use locales just don't use `_()` and `_l()` functions.
Delete `bot_app/handlers/locale_settings.py` and change start logic in `bot_app/handlers/start.py`


Software to change locale files - https://poedit.net/

Off guid - https://docs.aiogram.dev/en/dev-3.x/utils/i18n.html

Запускаємо бота і він напише
NAME FOR I18N FILE IS aiogram2_bot_sample_lang
саме цю назву потрібно вставити скрізь внизу щоб створити правильно файли локалізації


`cd bot_app`

# Create all files from your texts

`pybabel extract --input-dirs=. -o locales/aiogram3_bot_sample_lang.pot`

# Create localisations for all languages what you want to use. 

Modify `bot_app/markup/base.py::main_bot_language_keyboard`

`pybabel init -i locales/aiogram3_bot_sample_lang.pot -d locales -D aiogram3_bot_sample_lang -l en`

`pybabel init -i locales/aiogram3_bot_sample_lang.pot -d locales -D aiogram3_bot_sample_lang -l uk`

`pybabel init -i locales/aiogram3_bot_sample_lang.pot -d locales -D aiogram3_bot_sample_lang -l es`

# Compile all files after translation

`pybabel compile -d locales -D aiogram3_bot_sample_lang`
