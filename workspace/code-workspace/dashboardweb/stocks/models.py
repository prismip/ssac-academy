from django.db import models

# Create your models here.

class StockMaster(models.Model):
    symbol = models.CharField(max_length=10, primary_key=True)
    market = models.CharField(max_length=20)
    name = models.CharField(max_length=50)
    sector = models.CharField(max_length=50, null=True)
    industry = models.CharField(max_length=200, null=True)
    listing_date = models.CharField(max_length=10, null=True)
    settle_month = models.CharField(max_length=2, null=True)
    representative = models.CharField(max_length=100, null=True)
    homepage = models.CharField(max_length=50, null=True)
    region = models.CharField(max_length=50, null=True)

    def __str__(self):
        return self.name