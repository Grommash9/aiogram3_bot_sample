from aiogram.filters import Command, CommandObject
from aiogram.types import Message
from aiogram import Router

main_router = Router()


@main_router.message(Command(commands=["start"]))
async def start_echo_command(message: Message, command: CommandObject):
    await message.answer('hello i am bot')
