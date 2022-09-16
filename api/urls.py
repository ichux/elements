from django.urls import include, path
from rest_framework import routers

from api import post_views, views

router = routers.DefaultRouter()

router.register(
    "download-url", views.DownloadURLViewSet, basename="download-url-dataset"
)
router.register("prime", views.PrimeViewSet, basename="prime-dataset")
router.register("csv", views.CSVDataSet, basename="csv-dataset")


urlpatterns = [
    path("api/", include(router.urls)),
    path(
        "api/download-url-data/",
        post_views.DownloadURLData.as_view(),
        name="download_url_data",
    ),
]
