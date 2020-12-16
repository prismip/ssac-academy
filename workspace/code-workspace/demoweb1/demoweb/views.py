
from django.views.generic.base import TemplateView

# def home(request):
#     render(request, 'home.html', None)

class HomeView(TemplateView): # 
    template_name = 'home.html'
