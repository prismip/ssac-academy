from django.shortcuts import render
from django.views.generic.base import View, TemplateView

from django.http import HttpResponse, JsonResponse

from django.core import serializers

from .models import StockMaster

# Create your views here.


class HomeView(TemplateView):
    template_name = "stocks/home.html"

class MarketInfoView(View):
    def get(self, request): # View에서 상속 받은 메서드 -> 재정의, 브라우저에서 get 요청을 보내면 호출되는 메서드
        # return HttpResponse("Hello, there !!!!!!!!", content_type="text/plain;charset=utf-8") # HTML을 응답하는 객체 반환
        import FinanceDataReader as fdr
        from datetime import datetime, timedelta
        import json

        today = datetime.today() - timedelta(days=10)
        today_str = today.strftime("%Y-%m-%d")

        info = {}
        df = fdr.DataReader('KS11', today_str)
        df = df.tail(5).reset_index()
        df['Date'] = df['Date'].astype('string')
        info['kospi'] = [ list(row[:5]) for row in df.values ]

        df = fdr.DataReader('KQ11', today_str)
        df = df.tail(5).reset_index()
        df['Date'] = df['Date'].astype('string')
        info['kosdaq'] = [ list(row[:5]) for row in df.values ]

        df = fdr.DataReader('DJI', today_str)
        df = df.tail(5).reset_index()
        df['Date'] = df['Date'].astype('string')
        info['dowjones']  = [ list(row[:5]) for row in df.values ]

        df = fdr.DataReader('IXIC', today_str)
        df = df.tail(5).reset_index()
        df['Date'] = df['Date'].astype('string')
        info['nasdaq']  = [ list(row[:5]) for row in df.values ]

        info_json = json.dumps(info, ensure_ascii=False)

        return HttpResponse(info_json, content_type="application/json")
        
        
class SearchView(View):
    def get(self, request, key):
        searched_stocks = StockMaster.objects.filter(name__contains=key) # name like %key%
        serialized_stocks = serializers.serialize('json', searched_stocks) # serialize : instance -> json string
        return JsonResponse(serialized_stocks, safe=False, json_dumps_params={'ensure_ascii':False})

class StocksDetailView(View):
    def get(self, request, pk):

        import FinanceDataReader as fdr
        import json

        # stock = StockMaster.objects.get(symbol=pk)
        stocks = StockMaster.objects.filter(symbol=pk)
        stocks = list(stocks.values()) # django의 모델 인스턴스 컬렉션을 일반 리스트로 변경
        # print(stocks)
        for stock in stocks:
            stock_info = fdr.DataReader(pk, '20200101').fillna('').reset_index()
            stock_info["Date"] = stock_info['Date'].astype('string')
            stock['stats'] = stock_info.values.tolist()
        serialized_stocks = json.dumps(stocks, ensure_ascii=False) #
        return HttpResponse(serialized_stocks, content_type="application/json")

