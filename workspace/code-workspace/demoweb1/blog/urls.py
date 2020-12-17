from django.urls import path

from blog.views import PostLV

app_name = 'blog'

urlpatterns = [

    path('', PostLV.as_view(), name="index"),

]