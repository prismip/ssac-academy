from django.http.response import HttpResponse
from django.shortcuts import render

from polls.repository import PollsRepository
# Create your views here.

def index(request):

    repository = PollsRepository()
    question_list = repository.select_questions()

    # print(question_list)
    context = { 'question_list': question_list }

    return render(request, "polls/index.html", context) # context는 index.html을 처리할 때 사용할 수 있도록 전달하는 데이터


def detail(request, question_id):

    # 테스트용 코드
    # return HttpResponse("<h1>Question Detail ({0}) Page</h1>".format(question_id))

    # 1. Question 조회 + Choice 조회
    repository = PollsRepository()
    question = repository.select_question_by_id(question_id)
    choice_list = repository.select_choice_by_question_id(question_id)
    question.choices = choice_list

    # 2. 템플릿으로 이동 (데이터도 함께 전달)
    return render(request, 'polls/detail.html', { 'question': question })
    
    