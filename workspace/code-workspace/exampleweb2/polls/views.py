from django.http.response import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404

from django.views.generic import ListView, DetailView

from django.urls import reverse

from polls.repository import PollsRepository
from polls.models import Question, Choice

# Create your views here.

def index(request):
    question_list = Question.objects.all()
    # print(question_list)
    context = { 'question_list': question_list }
    return render(request, "polls/index.html", context) # context는 index.html을 처리할 때 사용할 수 있도록 전달하는 데이터

class IndexView(ListView):
    model = Question # Question에서 목록을 조회하시오
    context_object_name = 'question_list' # 템플릿으로 전달할 데이터 이름
    template_name = 'polls/index.html' # 이동해야할 템플릿 지정

def detail(request, question_id):

    # 1. Question 조회 + Choice 조회
    # question = get_object_or_404(Question, pk=question_id) # 데이터 조회 + 없으면 404 오류
    question = Question.objects.get(id=question_id)

    # 2. 템플릿으로 이동 (데이터도 함께 전달)
    return render(request, 'polls/detail.html', { 'question': question })

class QuestionDetailView(DetailView):
    model = Question
    context_object_name = 'question'
    template_name = 'polls/detail.html'


def vote(request, question_id):
    # 테스트용 코드
    # return HttpResponse("<h1>Vote for Question ({0}) Page</h1>".format(question_id))

    # 사용자가 Form에 입력해서 Post로 전송한 choice 값 읽기
    choice_id = request.POST['choice'] # request.POST['name 속성의 값'] : post로 전송된 요청 데이터를 읽은 방법 -> 문자열
    choice_id = int(choice_id)
    
    # 사용자가 선택한 Choice의 votes값을 1 증가 (데이터베이스 변경 사항)
    # repository = PollsRepository()
    # repository.update_choice_votes(choice_id)
    
    # question = Question.objects.get(id=question_id)
    # choice = question.choice_set.get(id=choice_id)
    choice = Choice.objects.get(id=choice_id)
    choice.votes += 1 # ORM 객체의 필드 값 변경 (데이터 변경)
    choice.save() # 데이터 베이스에 변경 내용 저장

    # 투표 결과 화면으로 이동 (redirect 이동 : 브라우저로 응답을 보내는데 이 응답이 즉시 다시 서버로 새로운 요청을 보내도록 처리)
    return HttpResponseRedirect(reverse("polls:results", args=(question_id, ))) # reverse : urls.py에 등록된 요청 경로를 가져와서 사용
    

def results(request, question_id):
   
    # 1. Question 조회 + Choice 조회
    # question = get_object_or_404(Question, pk=question_id) # 데이터 조회 + 없으면 404 오류
    question = Question.objects.get(id=question_id)

    # 2. 템플릿으로 이동 (데이터도 함께 전달)
    return render(request, 'polls/results.html', { 'question': question })

class VoteResultView(DetailView):
    model = Question
    context_object_name = 'question'
    template_name = 'polls/results.html'
    