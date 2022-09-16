import os
import shutil
import time

import requests
from django.conf import settings
from django.core.management.base import BaseCommand
from rest_framework import status

from api import logger
from api.models import CSVData, DownloadURL

FILE_LOCATION = settings.BASE_DIR / "ancillaries" / ".essential-data.csv"


def pull_down(url):
    """
    Downloads the necessary CSV file
    """
    try:
        response = requests.get(url, stream=True)

        if response.status_code == status.HTTP_200_OK:
            with open(FILE_LOCATION, "wb") as handle:
                for chunk in response.iter_content(chunk_size=512):
                    if chunk:
                        handle.write(chunk)

        if os.path.exists(FILE_LOCATION):
            shutil.move(
                str(FILE_LOCATION),
                str(settings.BASE_DIR / "essential-data.csv"),
            )
            logger.info("New file downloaded")
    except (
        requests.exceptions.HTTPError,
        requests.exceptions.ConnectionError,
        requests.exceptions.RequestException,
    ) as e:
        logger.error(f"requests.exceptions: {e}")

    time.sleep(int(os.getenv("CHECK_URL_INTERVAL")))


class Command(BaseCommand):
    help = "Download CSV file"

    def handle(self, *args, **options):
        """
        Monitors and executes conditions necessary to ensure a CSV file
        is downloaded.
        """
        try:
            while True:
                first_url = DownloadURL.objects.first()

                if first_url:
                    if not CSVData.objects.first():
                        pull_down(first_url.url)
                    else:
                        if first_url.updated.time().strftime(
                            "%H:%M:%S"
                        ) > first_url.added.time().strftime("%H:%M:%S"):
                            pull_down(first_url.url)
        except (KeyboardInterrupt, SystemExit):
            pass
