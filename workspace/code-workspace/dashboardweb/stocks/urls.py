


from django.contrib import admin
from django.urls import path, include

from .views import HomeView, MarketInfoView, SearchView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    path('market/', MarketInfoView.as_view(), name="market"),
    path('search/<str:key>', SearchView.as_view(), name="search"),
]
