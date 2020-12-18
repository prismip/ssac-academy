
from django.views.generic.base import TemplateView
from django.views.generic import CreateView
from django.contrib.auth.forms import UserCreationForm

from django.contrib.auth.mixins import AccessMixin

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

# 의미상 재사용 기능을 정의한 클래스 
class OwnerOnlyMixin(AccessMixin):
    raise_exception = True
    permission_denied_message = "Owner only can update/delete the object"

    def get(self, request, *args, **kwargs):
        self.object = self.get_object()
        if self.request.user != self.object.owner:
            self.handle_no_permission()
        return super().get(request, *args, **kwargs)
