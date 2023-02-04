from pathlib import Path
from dotenv import load_dotenv
load_dotenv()
import os

cwd = Path().cwd()

BASE_URL = os.getenv("WEBHOOK_HOST", "https://example.com")
MAIN_BOT_TOKEN = os.getenv("MAIN_BOT_TOKEN")

WEB_SERVER_HOST = os.getenv('BOT_SERVER_HOST')
WEB_SERVER_PORT = os.getenv('BOT_SERVER_PORT')
API_ROUTE_URL = os.getenv('API_BASE_URL')
MAIN_BOT_PATH = f"/aiogram_{cwd.name}/main"
REDIS_DSN = "redis://127.0.0.1:6379"


MYSQL = {
    'host': os.getenv('MYSQL_HOST'),
    'user': os.getenv('MYSQL_USER'),
    'password': os.getenv('MYSQL_PASSWORD'),
    'db': os.getenv('MYSQL_DB_NAME'),
    'port': int(os.getenv('MYSQL_PORT'))
    # 'unix_socket': '/var/run/mysqld/mysqld.sock'
}
