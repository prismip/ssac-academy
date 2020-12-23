from django.shortcuts import render
from django.views.generic.detail import DetailView
from django.views.generic.list import ListView

from django.views.generic import CreateView
from django.contrib.auth.mixins import LoginRequiredMixin

from django.urls import reverse_lazy
from django.shortcuts import redirect

from .models import Album, Photo
from .forms import PhotoInlineFormSet

# Create your views here.

class AlbumLV(ListView):
    model = Album

class AlbumDV(DetailView):
    model = Album

class PhotoDV(DetailView):
    model = Photo

######################################

class AlbumPhotoCV(LoginRequiredMixin, CreateView):
    model = Album
    fields = ('name', 'description')
    success_url = reverse_lazy('photo:index')

    def get_context_data(self, **kwargs): # 템플릿에 전달하는 데이터에 변화를 줄 때 구현하는 메서드
        context = super().get_context_data(**kwargs)
        if self.request.POST:
            context['formset'] = PhotoInlineFormSet(self.request.POST, self.request.FILES)
        else:
            context['formset'] = PhotoInlineFormSet()
        return context

    def form_valid(self, form):
        form.instance.owner = self.request.user
        context = self.get_context_data()
        formset = context['formset']
        for photoform in formset:
            photoform.instance.owner = self.request.user
        if formset.is_valid():
            self.object = form.save()
            formset.instance = self.object
            formset.save()
            return redirect(self.get_success_url())
        else:
            return self.render_to_response(self.get_context_data(form=form))
