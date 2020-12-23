from django.shortcuts import render

from django.views.generic.list import ListView

from .models import Album

# Create your views here.

class AlbumLV(ListView):
    model = Album
