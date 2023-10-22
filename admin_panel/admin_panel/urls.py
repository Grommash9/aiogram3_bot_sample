from django.contrib import admin
from django.urls import path
from django_otp.admin import OTPAdminSite
from . import settings


if not settings.DEBUG:
    admin.site.__class__ = OTPAdminSite


from . views import index

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index)
]
