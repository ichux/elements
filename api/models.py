from django.db import models
from django.db.models import Model


class TimeStampedModel(models.Model):
    added = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class DownloadURL(TimeStampedModel):
    url = models.TextField()

    class Meta:
        verbose_name_plural = "Download URL"

    def __str__(self):
        return f"{self.id}: {self.url}"


class Prime(TimeStampedModel):
    processing = models.BooleanField(default=False)

    class Meta:
        verbose_name_plural = "Prime"

    def __str__(self):
        return f"{self.id}: {self.processing}"


class CSVData(TimeStampedModel):
    image = models.TextField()
    title = models.TextField()
    description = models.TextField()

    class Meta:
        verbose_name_plural = "CSV Data"

    def __str__(self):
        output = ""
        if self.image:
            output += self.image

        if self.title:
            output += self.title
        else:
            output += self.description

        return f"{self.id}: {output}"
