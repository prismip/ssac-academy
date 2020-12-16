from django.shortcuts import render
from django.views.generic.list import ListView

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


