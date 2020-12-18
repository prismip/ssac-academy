from django.urls import path

from bookmark.views import BookmarkLV, BookmarkDV
from bookmark.views import BookmarkCreateView

app_name = 'bookmark'

urlpatterns = [

    path('', BookmarkLV.as_view(), name="index"),
    path('<int:pk>/', BookmarkDV.as_view(), name="detail"),

    # Example /bookmark/add/
    path('add/', BookmarkCreateView.as_view(), name='add'),

]