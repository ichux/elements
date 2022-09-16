from rest_framework import serializers

from api.models import CSVData, DownloadURL, Prime


class DownloadURLSerializer(serializers.ModelSerializer):
    class Meta:
        model = DownloadURL
        fields = ["url"]


class PrimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Prime
        fields = ["processing"]


class CSVDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = CSVData
        fields = ["image", "title", "description"]
