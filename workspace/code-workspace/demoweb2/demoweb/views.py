
from django.views.generic.base import TemplateView
from django.views.generic import CreateView
from django.contrib.auth.forms import UserCreationForm

from django.urls import reverse_lazy

# def home(request):
#     render(request, 'home.html', None)

class HomeView(TemplateView): # 
    template_name = 'home.html'

class UserCreateView(CreateView):
    template_name = 'registration/register.html'
    form_class = UserCreationForm
    success_url = reverse_lazy('register_done') # reverse_lazy : urls.py 에 등록된 url정보를 가져오는 기능

class UserCreateDoneView(TemplateView):
    template_name = 'registration/register_done.html'
