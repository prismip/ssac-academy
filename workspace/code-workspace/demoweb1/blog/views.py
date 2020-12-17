from django.shortcuts import render

from django.views.generic import ListView
from django.views.generic.detail import DetailView
from django.views.generic import ArchiveIndexView, YearArchiveView, MonthArchiveView
from django.views.generic import DayArchiveView, TodayArchiveView 

from blog.models import Post

# Create your views here.

class PostLV(ListView):
    # 목록을 조회해서 
    model = Post
    # 템플릿(default : blog/post_list.html)에 데이터(default: object_list) 전달
    template_name = "blog/post_all.html"
    context_object_name = "posts"
    paginate_by = 2 # 페이징 처리 설정 (한 화면에 2개씩 표시)

class PostDV(DetailView):
    model = Post
    # template_name = "blog/post_detail.html"   # 명시적으로 지정하지 않을 경우
    # context_object_name = "object"            # 명시적으로 지정하지 않을 경우


## Archive Views

class PostAV(ArchiveIndexView):
    model = Post
    date_field = 'modify_dt'
