from django.db import models

# Create your models here.

class Post(models.Model):

    title = models.CharField(verbose_name="TITLE", max_length=100)
    slug = models.SlugField(verbose_name="SLUG", allow_unicode=True, help_text="one word for title alias")
    description = models.CharField(verbose_name="DESCRIPTION", max_length=100)
    content = models.TextField(verbose_name="CONTENT")
    create_dt = models.DateTimeField(verbose_name="CREATE DATE", auto_now_add=True)
    modify_dt = models.DateTimeField(verbose_name="CREATE DATE", auto_now=True)

    def __str__(self):
        return self.title

