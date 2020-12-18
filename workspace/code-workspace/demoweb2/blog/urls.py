from django.urls import path, re_path

from blog.views import PostLV, PostDV, PostAV, PostYAV, PostMAV, PostDAV, PostTAV
from blog.views import PostCreateView, PostChangeLV, PostDeleteView, PostUpdateView

app_name = 'blog'

urlpatterns = [

    path('', PostLV.as_view(), name="index"),

    # path('<int:pk>/')
    # Example : /blog/post/this-is-title/
    re_path(r'^post/(?P<slug>[-\w]+)/$', PostDV.as_view(), name="post_detail"),

    # Example : /blog/archive/
    path('archive/', PostAV.as_view(), name='post_archive'),

    # Example: /blog/archive/2019/
    path('archive/<int:year>/', PostYAV.as_view(), name='post_year_archive'),

    # Example: /blog/archive/2019/12/
	path('archive/<int:year>/<int:month>/', PostMAV.as_view(), name='post_month_archive'),

    # Example: /blog/archive/2019/12/17/    
	path('archive/<int:year>/<int:month>/<int:day>/', PostDAV.as_view(), name='post_day_archive'),

    # Example: /blog/archive/today/
	path('archive/today/', PostTAV.as_view(), name='post_today_archive'),

    # Example: /blog/add/
    path('add/', PostCreateView.as_view(), name="add"),

    # Example: /blog/change/
    path('change/', PostChangeLV.as_view(), name="change"),

    # Example: /blog/99/delete/
    path('<int:pk>/delete/', PostDeleteView.as_view(), name="delete"),

    # Example: /blog/99/update/
    path('<int:pk>/update/', PostUpdateView.as_view(), name="update"),

]