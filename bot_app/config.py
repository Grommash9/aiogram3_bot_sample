from pathlib import Path

from aiogram.utils.i18n import gettext as _
from dotenv import load_dotenv

load_dotenv()
import os

cwd = Path().cwd()

BASE_URL = os.getenv("WEBHOOK_HOST", "https://example.com")
MAIN_BOT_TOKEN = os.getenv("MAIN_BOT_TOKEN")
WEB_SERVER_HOST = os.getenv("BOT_SERVER_HOST", "127.0.0.1")
WEB_SERVER_PORT = os.getenv("BOT_SERVER_PORT")
MAIN_BOT_PATH = f"/{cwd.name}/main"
REDIS_DSN = "redis://127.0.0.1:6379"
BASE_DIR = Path(__file__).parent
I18N_DOMAIN = f"{Path(__file__).parent.parent.name}_lang"
print(f"\033[93mNAME FOR I18N FILE IS {Path(__file__).parent.parent.name}_lang \033[0m")
LOCALES_DIR = BASE_DIR / "locales"


MYSQL = {
    "host": os.getenv("MYSQL_HOST"),
    "user": os.getenv("MYSQL_USER"),
    "password": os.getenv("MYSQL_PASSWORD"),
    "db": os.getenv("MYSQL_DB_NAME"),
    "port": os.getenv("MYSQL_PORT"),
}
