from django.urls import path

from bookmark.views import BookmarkLV, BookmarkDV
from bookmark.views import BookmarkCreateView, BookmarkChangeLV, BookmarkDeleteView, BookmarkUpdateView

app_name = 'bookmark'

urlpatterns = [

    path('', BookmarkLV.as_view(), name="index"),
    path('<int:pk>/', BookmarkDV.as_view(), name="detail"),

    # Example /bookmark/add/
    path('add/', BookmarkCreateView.as_view(), name='add'),

    # Example /bookmark/change/
    path('change/', BookmarkChangeLV.as_view(), name='change'),

    # Example /bookmark/99/delete
    path('<int:pk>/delete/', BookmarkDeleteView.as_view(), name="delete"),

    # Example /bookmark/99/update
    path('<int:pk>/update/', BookmarkUpdateView.as_view(), name='update'),

]