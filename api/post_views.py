from datetime import datetime, timedelta

from django.db import IntegrityError
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from api.models import DownloadURL
from api.serializers import DownloadURLSerializer


class DownloadURLData(APIView):
    def post(self, request, *args, **kwargs):
        url = request.data.get("url")

        if not url:
            return Response(
                {"message": "Invalid data provided. Check for a missing variable"},
                status.HTTP_400_BAD_REQUEST,
            )

        if not DownloadURL.objects.first():
            response = DownloadURL.objects.create(url=url)

            content = {
                "message": "Request submitted successfully",
                "tracking_id": response.id,
            }

            return Response(content, status.HTTP_201_CREATED)

        return Response(
            {"message": "Use the PUT method to update this value"},
            status.HTTP_400_BAD_REQUEST,
        )

    def put(self, request, *args, **kwargs):
        url = request.data.get("url")

        if not url:
            return Response(
                {"message": "Invalid data provided. Check for a missing variable"},
                status.HTTP_400_BAD_REQUEST,
            )

        first_url = DownloadURL.objects.first()
        if not first_url:
            return Response(
                {"message": "Use the POST method to add this value"},
                status.HTTP_400_BAD_REQUEST,
            )
        else:
            if first_url.url != url:
                first_url.url = url
                first_url.save()

                content = {
                    "message": "Request updated successfully",
                }

                return Response(content, status.HTTP_201_CREATED)
            else:
                return Response(
                    {"message": "Old and new value are the same"},
                    status.HTTP_400_BAD_REQUEST,
                )
