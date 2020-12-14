from django.db import models

# Create your models here.

class Question:
    """
    데이터베이스의 polls_question 테이블과 매핑되는 클래스 (polls_question 테이블의 데이터를 저장하는 클래스)
    """

    def __init__(self, id=0, question_text='', pub_date=''):
        self.id = id
        self.question_text = question_text
        self.pub_date = pub_date

    def __str__(self):
        # str(...) 했을 때 호출되는 메서드
        return self.question_text
