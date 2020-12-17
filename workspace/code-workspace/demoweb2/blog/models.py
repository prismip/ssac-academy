from django.db import models

from django.urls import reverse

# Create your models here.

class Post(models.Model):

    title = models.CharField(verbose_name="TITLE", max_length=100)
    slug = models.SlugField(verbose_name="SLUG", max_length=100, allow_unicode=True, help_text="one word for title alias") # this is title -> this-is-title
    description = models.CharField(verbose_name="DESCRIPTION", max_length=200)
    content = models.TextField(verbose_name="CONTENT")
    create_dt = models.DateTimeField(verbose_name="CREATE DATE", auto_now_add=True)
    modify_dt = models.DateTimeField(verbose_name="MODIFY DATE", auto_now=True)

    # ORM 객체 (테이블) 관리와 관련된 부가 정보 등록
    class Meta:
        verbose_name = 'post'
        verbose_name_plural = 'posts'
        db_table = 'blog_posts'
        ordering = ('-modify_dt',)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse("blog:post_detail", args=(self.slug,)) # /blog/this-is-title

    def get_previous(self): # 이전 글 가져오기
        return self.get_previous_by_modify_dt()

    def get_next(self): # 다음 글 가져오기
        return self.get_next_by_modify_dt()
    

