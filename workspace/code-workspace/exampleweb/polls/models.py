from django.db import models

# Create your models here.

class Question:
    """
    데이터베이스의 polls_question 테이블과 매핑되는 클래스 (polls_question 테이블의 데이터를 저장하는 클래스)
    """

    def __init__(self, id=0, question_text='', pub_date='', choices=None):
        self.id = id
        self.question_text = question_text
        self.pub_date = pub_date
        self.choices = choices # Question테이블과 Choice 테이블의 1 : Many 관계를 구현하는 변수

    def __str__(self):
        # str(...) 했을 때 호출되는 메서드
        return self.question_text

class Choice:
    """
    데이터베이스의 polls_choice 테이블과 매핑되는 클래스 (polls_choice 테이블의 데이터를 저장하는 클래스)
    """

    def __init__(self, id=0, question_id=0, choice_text="", votes=0):
        self.id = id
        self.question_id = question_id
        self.choice_text = choice_text
        self.votes = votes

    def __str__(self):
        return self.choice_text
