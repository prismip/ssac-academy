from django.urls import path, include

from . import views

urlpatterns = [

    # Example : polls/
    path('', views.index, name="index"),

    # Example : polls/1 or polls/2 or polls/3 or .... polls/{n}
    path('<int:question_id>/', views.detail, name='detail') # <자료형:변수이름>
]