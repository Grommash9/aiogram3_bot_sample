from typing import Optional

from aiogram.types import User

from local_extensions.db_methods.base import create_con, create_dict_con
from local_extensions.models import TgUser


async def new(user: User) -> TgUser:
    con, cur = await create_con()
    await cur.execute(
        "insert ignore into tg_user (tg_chat_id, full_name, user_name, locale) "
        "VALUES (%s, %s, %s, %s)",
        (user.id, user.full_name, user.username, None),
    )

    await con.commit()
    await con.ensure_closed()
    return TgUser(user.id, user.full_name, user.username, None)


async def get(user: User) -> Optional[TgUser]:
    con, cur = await create_con()
    await cur.execute(
        "select tg_chat_id, full_name, user_name, locale from tg_user where tg_chat_id = %s",
        (user.id,),
    )
    user_data = await cur.fetchone()
    await con.ensure_closed()
    if user_data is None:
        return None
    return TgUser(*user_data)


async def update_locale(user: User, locale: str):
    con, cur = await create_con()
    await cur.execute(
        "update tg_user set locale = %s where tg_chat_id = %s", (locale, user.id)
    )
    await con.commit()
    await con.ensure_closed()
