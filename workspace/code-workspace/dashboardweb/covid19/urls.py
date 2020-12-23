from django.urls import path

from .views import ConfirmedStatView, HomeView, ConfirmedRegionView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    path('confirmed/', ConfirmedStatView.as_view(), name="confirmed"),
    path('confirmed/<str:region>/', ConfirmedRegionView.as_view(), name="confirmed_region")
]