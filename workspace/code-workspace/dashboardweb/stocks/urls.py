


from django.contrib import admin
from django.urls import path, include

from .views import HomeView, MarketInfoView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    path('market/', MarketInfoView.as_view(), name="market"),
]
