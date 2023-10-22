from django.db import models


class TgUser(models.Model):
    tg_chat_id = models.BigIntegerField(unique=True, null=False, primary_key=True)
    full_name = models.CharField(max_length=200)
    user_name = models.CharField(max_length=100, unique=True)
    locale = models.CharField(max_length=20)

    class Meta:
        db_table = "tg_user"
        verbose_name_plural = 'Користувачі бота'

    def __str__(self):
        return f"{self.user_name}"