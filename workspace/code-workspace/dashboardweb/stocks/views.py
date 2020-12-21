from django.shortcuts import render
from django.views.generic.base import View, TemplateView

from django.http import HttpResponse

# Create your views here.

class HomeView(TemplateView):
    template_name = "stocks/home.html"

class MarketInfoView(View):
    def get(self, request): # View에서 상속 받은 메서드 -> 재정의, 브라우저에서 get 요청을 보내면 호출되는 메서드
        return HttpResponse("Hello, there", content_type="text/plain;charset=utf-8") # HTML을 응답하는 객체 반환
