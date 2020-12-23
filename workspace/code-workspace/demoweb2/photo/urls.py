from django.urls import path

from .views import AlbumLV, AlbumDV, PhotoDV, AlbumPhotoCV

app_name = "photo"

urlpatterns = [
    # Example: /photo/
    path('', AlbumLV.as_view(), name='index'),

    # Example: /photo/album/, same as /photo/
    path('album', AlbumLV.as_view(), name='album_list'),

    # Example: /photo/album/99/
    path('album/<int:pk>/', AlbumDV.as_view(), name="album_detail"),

    # Example: /photo/photo/99/
    path('photo/<int:pk>', PhotoDV.as_view(), name='photo_detail'),

    # Example: /photo/album/add/
    path('album/add/', AlbumPhotoCV.as_view(), name='album_add'),
]