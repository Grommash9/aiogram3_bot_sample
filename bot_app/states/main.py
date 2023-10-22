from aiogram.fsm.state import State, StatesGroup


class NewBotCreation(StatesGroup):
    bot_token = State()
