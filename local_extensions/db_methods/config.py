from pathlib import Path

from dotenv import load_dotenv

load_dotenv()
import os

cwd = Path().cwd()


# sad
MYSQL = {
    "host": os.getenv("MYSQL_HOST"),
    "user": os.getenv("MYSQL_USER"),
    "password": os.getenv("MYSQL_PASSWORD"),
    "db": os.getenv("MYSQL_DB_NAME"),
    "port": int(os.getenv("MYSQL_PORT")),
}
