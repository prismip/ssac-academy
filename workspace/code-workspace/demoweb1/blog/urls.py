from django.urls import path, re_path

from blog.views import PostLV, PostDV, PostAV

app_name = 'blog'

urlpatterns = [

    path('', PostLV.as_view(), name="index"),

    # path('<int:pk>/')
    # Example : /blog/post/this-is-title/
    re_path(r'^post/(?P<slug>[-\w]+)/$', PostDV.as_view(), name="post_detail"),

    # Example : /blog/archive/
    path('archive/', PostAV.as_view(), name='post_archive'),

]