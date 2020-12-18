from django.shortcuts import render
from django.views.generic.detail import DetailView
from django.views.generic.list import ListView
from django.views.generic import CreateView, DeleteView, UpdateView

from django.contrib.auth.mixins import LoginRequiredMixin

from django.urls import reverse_lazy

from bookmark.models import Bookmark

# Create your views here.

# def index(request):
#     pass

class BookmarkLV(ListView):

    # 1. 목록 조회
    # 3. 템플릿으로 이동 (템플릿에서 사용할 수 있도록 데이터 전달)
    model = Bookmark
    # context_object_name = "object_list" : 템플릿으로 전달하는 데이터 이름(변수명), 명시적으로 지정하지 않을 경우 object_list 사용
    # template_name = "bookmark_list.html" : 지정하지 않을 경우 bookmark_list.html

class BookmarkDV(DetailView):
    model = Bookmark
    # context_object_name = "object" : 템플릿으로 전달하는 데이터 이름(변수명), 명시적으로 지정하지 않을 경우 object_list 사용
    # template_name = "bookmark_detail.html" : 지정하지 않을 경우 bookmark_list.html

class BookmarkCreateView(LoginRequiredMixin, CreateView): # LoginRequiredMixin : 로그인 하지 않은 사용자의 요청인 경우 로그인 화면으로 이동 처리하는 기능 제공
    model = Bookmark 
    fields = ['title', 'url'] # 입력 항목 지정
    success_url = reverse_lazy('bookmark:index')
    # template_name = "bookmark_form.html"
    
    def form_valid(self, form): # post 로 데이터가 전송되었을 때 데이터를 Form에 구성하고 호출하는 메서드
        form.instance.owner = self.request.user 
        return super().form_valid(form) 
		

