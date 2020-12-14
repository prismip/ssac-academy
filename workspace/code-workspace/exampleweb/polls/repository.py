import pymysql

from polls.models import Question

class PollsRepository:
    """
    polls application 관련 데이터베이스 연동(C, R, U, D) 코드를 구현한 클래스
    """
    
    def __init__(self):
        self.connection_info = { 'host': 'localhost', 'db': 'exampledb', 'user': 'root', 'password': 'Pa$$w0rd', 'charset': 'utf8' }

    def select_questions(self):
        conn = pymysql.connect(**self.connection_info)
        cursor = conn.cursor()

        sql = "select id, question_text, pub_date from polls_question"
        cursor.execute(sql)

        rows = cursor.fetchall() # 반환 값은 tuple의 list [ (...), (...), ..., (...) ]
        result = []
        for row in rows:
            # q = Question(row[0], row[1], row[2])
            q = Question(*row) # *(1, 2, 3) -> 1, 2, 3
            result.append(q)

        conn.close()

        return result