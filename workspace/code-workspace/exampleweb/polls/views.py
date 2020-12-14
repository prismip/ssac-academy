from django.shortcuts import render

from polls.repository import PollsRepository
# Create your views here.

def index(request):

    repository = PollsRepository()
    question_list = repository.select_questions()

    # print(question_list)
    context = { 'question_list': question_list }

    return render(request, "polls/index.html", context) # context는 index.html을 처리할 때 사용할 수 있도록 전달하는 데이터
