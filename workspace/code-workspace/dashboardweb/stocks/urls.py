


from django.contrib import admin
from django.urls import path, include

from .views import AptInfoByRegion, HomeView, MarketInfoView, SearchView, StocksDetailView, SearchView2, StocksDetailView2, AptHomeView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    
    path('market/', MarketInfoView.as_view(), name="market"),
    path('search/<str:key>', SearchView.as_view(), name="search"),
    path('detail/<str:pk>', StocksDetailView.as_view(), name="detail"),

    path('search2/<str:key>', SearchView2.as_view(), name="search"),
    path('detail2/<str:pk>', StocksDetailView2.as_view(), name="detail"),

    path('apt/', AptHomeView.as_view(), name="apt_home"),
    path('apt/<str:region>/', AptInfoByRegion.as_view(), name="apt_region_info"),
]
