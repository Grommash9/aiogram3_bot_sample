from typing import Any, Dict, Union

from aiogram import Bot
from aiogram.exceptions import TelegramUnauthorizedError
from aiogram.utils.token import TokenValidationError, validate_token
from aiohttp import web
from aiohttp.web_request import Request

from bot_app import config
from bot_app.misc import bot, routes


def is_bot_token(value: str) -> Union[bool, Dict[str, Any]]:
    try:
        validate_token(value)
    except TokenValidationError:
        return False
    return True


@routes.post(f"/user_notification")
async def send_any_notification(request: Request):
    """
    Get the request data as a JSON object.
    Create a new instance of the Bot class with the provided bot token and session.
    Use the Bot instance to call the send_message method with the provided target chat ID and message text.
    If there is an error during the message sending process, a JSON response with the error message and
    a status code of 500 will be returned.
    If the message is sent successfully, a JSON response with the message "ok" and the JSON representation
    of the message_data object will be returned, with a status code of 200.
    """
    data = await request.json()
    try:
        message_data = await Bot(data["bot_token"], session=bot.session).send_message(
            data["target_chat"], data["message_text"]
        )
    except Exception as e:
        return web.json_response({"error": str(e)}, status=500)
    return web.json_response(
        {"error": "ok", "message_data": message_data.json()}, status=200
    )
