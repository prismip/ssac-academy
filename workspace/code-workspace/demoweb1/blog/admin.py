from django.contrib import admin

from blog.models import Post

# Register your models here.

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    """
    Post 모델이 관리자 앱에서 어떻게 다루어지는지 설정하는 클래스
    """
    list_display = ['id', 'title', 'modify_dt'] # 관리자의 앱의 목록에서 표시될 항목
    list_filter = ['modify_dt']
    search_fields = ['title', 'content']
    prepopulated_fields = { 'slug': ('title', ) }

# admin.site.register(Post) # - admin 앱의 기본 관리 방식으로 관리
# admin.site.register(Post, PostAdmin) # 사용자 정의된 방식으로 관리하도록 모델 등록
