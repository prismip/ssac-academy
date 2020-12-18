from django.shortcuts import render

from django.views.generic import ListView
from django.views.generic.detail import DetailView
from django.views.generic import ArchiveIndexView, YearArchiveView, MonthArchiveView
from django.views.generic import DayArchiveView, TodayArchiveView 
from django.views.generic import CreateView, DeleteView, UpdateView

from django.contrib.auth.mixins import LoginRequiredMixin

from django.urls import reverse_lazy

from blog.models import Post

from demoweb.views import OwnerOnlyMixin

# Create your views here.

class PostLV(ListView):
    # 목록을 조회해서 
    model = Post # Post.objects.all()
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

class PostYAV(YearArchiveView):
    model = Post
    date_field = 'modify_dt'
    make_object_list = True

class PostMAV(MonthArchiveView):
    model = Post
    date_field = 'modify_dt'
    month_format='%m'  # url에서 월의 값을 숫자로 읽는 설정

class PostDAV(DayArchiveView):
    model = Post
    date_field = 'modify_dt'
    month_format='%m' # url에서 월의 값을 숫자로 읽는 설정

class PostTAV(TodayArchiveView):
    model = Post
    date_field = 'modify_dt'
    month_format='%m'


class PostCreateView(LoginRequiredMixin, CreateView):
    model = Post
    # fields = ['title', 'slug', 'description', 'content', 'tags']
    fields = ['title', 'slug', 'description', 'content']
    initial = {'slug': 'auto-filling-do-not-input'} 
    #fields = ['title', 'description', 'content', 'tags'] 
    success_url = reverse_lazy('blog:index')

    def form_valid(self, form):
        form.instance.owner = self.request.user
        return super().form_valid(form)

class PostChangeLV(LoginRequiredMixin, ListView):
    template_name = 'blog/post_change_list.html'

    def get_queryset(self):
        return Post.objects.filter(owner=self.request.user)

class PostDeleteView(OwnerOnlyMixin, DeleteView) :
    model = Post
    success_url = reverse_lazy('blog:index')

class PostUpdateView(OwnerOnlyMixin, UpdateView):
    model = Post
    # fields = ['title', 'slug', 'description', 'content', 'tags']
    fields = ['title', 'slug', 'description', 'content']
    success_url = reverse_lazy('blog:index')