from django.http.response import HttpResponse
from django.shortcuts import render

from django.views.generic.base import TemplateView, View

# Create your views here.

class HomeView(TemplateView):
    template_name = 'covid19/home.html'

class ConfirmedStatView(View):
    def get(self, request):
    
        import requests
        import xmltodict
        import json

        url = 'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson'
        api_key = 'R%2BBEwJ49XVmTutdoCAdNq4m7wjOsdFNhVtlzkxWVeZJPhwQqWbGcD7CNeQPipFzIWAanQVw%2FrPLsGkfcYvD4AQ%3D%3D'
        # http://localhost:8000/a/b/c/?name=x&age=30
        qs = 'serviceKey={0}&pageNo={1}&numOfRows={2}&startCreateDt={3}&endCreateDt={4}'.format(api_key, 1, 10, '20201222', '20201222')

        response = requests.get(url + "?" + qs)

        response_dict = xmltodict.parse(response.content) # xml -> ordereddict
        response_json = json.dumps(response_dict, ensure_ascii=False) # ordereddict -> json-string
        response_dict2 = json.loads(response_json) # json-string -> general dict
        item_list = response_dict2['response']['body']['items']['item']
        item_list_json = json.dumps(item_list, ensure_ascii=False)

        return HttpResponse(item_list_json, content_type='application/json;charset=utf-8')

class ConfirmedRegionView(View):
    def get(self, request, region):
    
        import requests
        import xmltodict
        import json
        from datetime import datetime, timedelta

        to_date = datetime.today().strftime("%Y%m%d") # 날짜 -> 'yyyymmdd'
        from_date = (datetime.today() - timedelta(days=10)).strftime("%Y%m%d")

        url = 'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson'
        api_key = 'R%2BBEwJ49XVmTutdoCAdNq4m7wjOsdFNhVtlzkxWVeZJPhwQqWbGcD7CNeQPipFzIWAanQVw%2FrPLsGkfcYvD4AQ%3D%3D'
        # http://localhost:8000/a/b/c/?name=x&age=30
        qs = 'serviceKey={0}&pageNo={1}&numOfRows={2}&startCreateDt={3}&endCreateDt={4}'.format(api_key, 1, 10, from_date, to_date)

        response = requests.get(url + "?" + qs)

        response_dict = xmltodict.parse(response.content) # xml -> ordereddict
        response_json = json.dumps(response_dict, ensure_ascii=False) # ordereddict -> json-string
        response_dict2 = json.loads(response_json) # json-string -> general dict
        item_list = response_dict2['response']['body']['items']['item']

        item_list_by_region = [ item for item in item_list if item['gubun'] == region ]
        
        item_list_by_region_json = json.dumps(item_list_by_region, ensure_ascii=False)
        return HttpResponse(item_list_by_region_json, content_type='application/json;charset=utf-8')
