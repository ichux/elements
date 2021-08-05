import sys
from pyclbr import readmodule

from django.apps import apps
from django.contrib import admin
from django.utils.translation import gettext_lazy


class DownloadURLAdmin(admin.ModelAdmin):
    ordering = ["-added"]
    search_fields = ["url"]
    list_display = ["url"]


class PrimeAdmin(admin.ModelAdmin):
    ordering = ["-added"]
    search_fields = ["processing"]
    list_display = ["processing"]


class CSVDataAdmin(admin.ModelAdmin):
    ordering = ["-added"]
    search_fields = ["image", "title", "description"]
    list_display = ["image", "title", "description"]


known_classes = dict(readmodule(__name__).items())
current_module = sys.modules[__name__]

# dynamically register all Django models
for model in apps.get_app_config("api").get_models():
    try:
        declared_admin_class = f"{model.__name__}Admin"
        if declared_admin_class in known_classes.keys():
            admin.site.register(model, getattr(current_module, declared_admin_class))
        else:
            admin.site.register(model)
    except admin.site.AlreadyRegistered:
        pass
