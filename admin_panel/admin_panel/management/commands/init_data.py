from django.core.management.base import BaseCommand
from admin_panel.models import TgUser


class Command(BaseCommand):
    help = 'Adds default data to the database'

    def handle(self, *args, **options):
        transaction_statuses = [
            ('123123', 'Antoxa', '@pes_patron', 'en')
        ]
        for tg_chat_id, full_name, user_name, locale in transaction_statuses:
            TgUser.objects.get_or_create(tg_chat_id=tg_chat_id, full_name=full_name, user_name=user_name, locale=locale)

        print('Initial data added successfully!')
