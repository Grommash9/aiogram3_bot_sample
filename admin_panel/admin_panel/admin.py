from django.contrib import admin
from .models import TgUser


@admin.register(TgUser)
class TgUserAdmin(admin.ModelAdmin):
    list_display = ('tg_chat_id', 'full_name', 'user_name', 'locale')

