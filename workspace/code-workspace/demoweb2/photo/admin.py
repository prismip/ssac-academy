from django.contrib import admin

from .models import Photo, Album

# Register your models here.

class PhotoInline(admin.StackedInline): # 다른 모델과 함께 보여 줄 수 있는 설정 클래스
    model = Photo
    extra = 2

@admin.register(Album)
class AlbumAdmin(admin.ModelAdmin):
    inlines = (PhotoInline,) # 인라인 설정 클래스를 가져와서 다른 모델을 같은 화면에 표시
    list_display = ('id', 'name', 'description')

@admin.register(Photo)
class PhotoAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'upload_dt')
