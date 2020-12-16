from django.db import models

# Create your models here.

class Question(models.Model):

    question_text = models.CharField(max_length=200)    # varchar(200)
    pub_date = models.DateTimeField('date published')   # datetime
   
    def __str__(self):
        # str(...) 했을 때 호출되는 메서드
        return self.question_text

class Choice(models.Model):
   
    question = models.ForeignKey(Question, on_delete=models.CASCADE) # Many to One의 관계를 정의하는 필드
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
    
    def __str__(self):
        return self.choice_text
