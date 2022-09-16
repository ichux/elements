import csv
import time

from django.conf import settings
from django.core.management.base import BaseCommand
from watchdog.events import PatternMatchingEventHandler

from api import logger
from api.models import CSVData, Prime


class CSVWatcher(PatternMatchingEventHandler):
    def __init__(
        self,
        patterns=None,
        ignore_patterns=None,
        ignore_directories=False,
        case_sensitive=False,
    ):
        super().__init__(patterns, ignore_patterns, ignore_directories, case_sensitive)

    def process(self, event):
        """
        event.event_type
            'modified' | 'created' | 'moved' | 'deleted'
        event.is_directory
            True | False
        event.src_path
            path/to/observed/file
        """
        logger.info(f"{event.src_path} was {event.event_type}")
        first_prime, response = Prime.objects.first(), None

        if not first_prime:
            first_prime = Prime.objects.create(processing=True)
        else:
            # start processing, lock read
            first_prime.processing = True
            first_prime.save()

        if event.event_type == "modified":
            CSVData.objects.all().delete()

        with open(event.src_path, "r") as input_file:
            for row in csv.DictReader(input_file):
                # yield row
                CSVData.objects.create(
                    image=row.get("image"),
                    title=row.get("title"),
                    description=row.get("description"),
                )

        # done processing, allow read
        first_prime.processing = False
        first_prime.save()

    def on_modified(self, event):
        self.process(event)

    def on_created(self, event):
        self.process(event)

    def on_deleted(self, event):
        logger.error(f"{event.src_path} was deleted")


class Command(BaseCommand):
    help = "Monitor CSV file for changes"

    def handle(self, *args, **options):
        while True:
            CSVWatcher(patterns=[settings.BASE_DIR / "essential-data.csv"])
            time.sleep(0.5)
