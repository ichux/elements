from rest_framework import mixins, permissions, viewsets

from api.models import CSVData, DownloadURL, Prime
from api.pagination import CSVSetPagination
from api.serializers import CSVDataSerializer, DownloadURLSerializer, PrimeSerializer


class DownloadURLViewSet(viewsets.ModelViewSet):

    queryset = DownloadURL.objects.all().order_by("id")
    serializer_class = DownloadURLSerializer


class PrimeViewSet(viewsets.ModelViewSet):

    queryset = Prime.objects.all().order_by("id")
    serializer_class = PrimeSerializer


class CSVDataSet(viewsets.ModelViewSet):

    queryset = CSVData.objects.all().order_by("id")
    serializer_class = CSVDataSerializer
    pagination_class = CSVSetPagination
