from django.shortcuts import render

def home(request):

    return render(request, "home.html", None) # context는 index.html을 처리할 때 사용할 수 있도록 전달하는 데이터