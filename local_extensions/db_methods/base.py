from aiomysql import Connection, Cursor, DictCursor, connect
from pymysql import connect as sync_connect
from pymysql.cursors import DictCursor as SyncDictCursor

from local_extensions.db_methods.config import MYSQL


async def create_con():
    con: Connection = await connect(**MYSQL)
    cur: Cursor = await con.cursor()
    return con, cur


async def create_dict_con():
    con: Connection = await connect(**MYSQL)
    cur: DictCursor = await con.cursor(DictCursor)
    return con, cur


def sync_create_con():
    con = sync_connect(**MYSQL)
    cur = con.cursor()
    return con, cur


def sync_dict_con():
    con = sync_connect(**MYSQL)
    cur = con.cursor(SyncDictCursor)
    return con, cur
