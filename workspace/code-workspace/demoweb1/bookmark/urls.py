from django.urls import path

from bookmark.views import BookmarkLV

app_name = 'bookmark'

urlpatterns = [

    path('', BookmarkLV.as_view(), name="index"),

]