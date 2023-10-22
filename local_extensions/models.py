from dataclasses import dataclass
from typing import Optional


@dataclass
class TgUser:
    tg_user_id: int
    full_name: str
    user_name: str
    locale: Optional[str] = None
