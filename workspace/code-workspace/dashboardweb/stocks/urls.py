


from django.contrib import admin
from django.urls import path, include

from .views import AptInfoByRegion, HomeView, MarketInfoView, SearchView, StocksDetailView, AptHomeView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    path('market/', MarketInfoView.as_view(), name="market"),
    path('search/<str:key>', SearchView.as_view(), name="search"),
    path('<str:pk>', StocksDetailView.as_view(), name="detail"),

    path('apt/', AptHomeView.as_view(), name="apt_home"),
    path('apt/<str:region>/', AptInfoByRegion.as_view(), name="apt_region_info"),
]
