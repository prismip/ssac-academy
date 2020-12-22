from django.urls import path

from .views import ConfirmedStatView, HomeView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    path('confirmed/', ConfirmedStatView.as_view(), name="confirmed")
]