import json

from django.test import TestCase
from django.test.client import Client
from rest_framework.test import APITestCase

from api.models import CSVData, DownloadURL, Prime

URL = "https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"


class ModelsTestCase(TestCase):
    def test_download_url(self):
        """DownloadURL model is tested"""

        response = DownloadURL.objects.create(url=URL)
        self.assertEqual(response.url, URL)

    def test_prime(self):
        """Prime model is tested"""

        response = Prime.objects.create(processing=True)
        self.assertEqual(response.processing, True)

    def test_csv_data(self):
        """CSVData model is tested"""

        response = CSVData.objects.create(
            image="image1", title="title1", description="description1"
        )
        self.assertEqual(response.image, "image1")
        self.assertEqual(response.title, "title1")
        self.assertEqual(response.description, "description1")


class APITest(TestCase):
    def setUp(self):
        self.c = Client()

    def test_api(self):
        response = self.c.get("/api/")
        self.assertEqual(response.status_code, 200)

    def test_api_data(self):
        response = self.c.get("/api/")
        needed = response.json()

        self.assertIn("api/download-url/", needed["download-url"])
        self.assertIn("/api/prime/", needed["prime"])
        self.assertIn("/api/csv/", needed["csv"])


class DownloadURLTest(TestCase):
    def setUp(self):
        self.c = Client()

    def test_download_url(self):
        response = self.c.get("/api/download-url/")
        self.assertEqual(response.status_code, 200)

    def test_download_url_data(self):
        response = self.c.get("/api/download-url/")
        self.assertEqual(response.json(), [])


class DownloadURLPostPutTest(APITestCase):
    def test_post(self):
        response = self.client.post(
            "/api/download-url-data/",
            json.dumps({"url": URL}),
            content_type="application/json",
        )
        self.assertEqual(
            response.json(),
            {"message": "Request submitted successfully", "tracking_id": 1},
        )

    def test_put(self):
        response = self.client.put(
            "/api/download-url-data/",
            json.dumps({"url": URL}),
            content_type="application/json",
        )
        self.assertEqual(
            response.json(),
            {"message": "Use the POST method to add this value"},
        )


class PrimeTest(TestCase):
    def setUp(self):
        self.c = Client()

    def test_prime(self):
        response = self.c.get("/api/prime/")
        self.assertEqual(response.status_code, 200)

    def test_prime_data(self):
        response = self.c.get("/api/prime/")
        self.assertEqual(response.json(), [])

    def test_individual_prime(self):
        response = self.c.get("/api/prime/1/")
        self.assertEqual(response.json(), {"detail": "Not found."})


class CSVTest(TestCase):
    def setUp(self):
        self.c = Client()

    def test_csv(self):
        response = self.c.get("/api/csv/")
        self.assertEqual(response.status_code, 200)

    def test_csv(self):
        response = self.c.get("/api/csv/")
        self.assertEqual(
            response.json(), {"count": 0, "next": None, "previous": None, "results": []}
        )

    def test_individual_csv(self):
        response = self.c.get("/api/csv/1/")
        self.assertEqual(response.json(), {"detail": "Not found."})

    def test_limit_offset_csv(self):
        response = self.c.get("/api/csv/?limit=10&offset=10")
        self.assertEqual(
            response.json().get("count"),
            0,
        )
