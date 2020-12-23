from django.urls import path

from .views import AlbumLV

app_name = "photo"

urlpatterns = [
    # Example: /photo/
    path('', AlbumLV.as_view(), name='index'),

    # Example: /photo/album/, same as /photo/
    path('album', AlbumLV.as_view(), name='album_list'),
]