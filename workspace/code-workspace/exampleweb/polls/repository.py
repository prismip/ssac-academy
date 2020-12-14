import pymysql

from polls.models import Question, Choice

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

    def select_question_by_id(self, question_id):
        conn = pymysql.connect(**self.connection_info)
        cursor = conn.cursor()

        sql = "select id, question_text, pub_date from polls_question where id = %s"
        cursor.execute(sql, (question_id, ))

        row = cursor.fetchone() # 반환 값은 tuple (...)
        
        # q = Question(row[0], row[1], row[2])
        q = Question(*row) # *(1, 2, 3) -> 1, 2, 3
        
        conn.close()

        return q

    def select_choice_by_question_id(self, question_id):
        conn = pymysql.connect(**self.connection_info)
        cursor = conn.cursor()

        sql = "select id, question_id, choice_text, votes from polls_choice where question_id = %s"
        cursor.execute(sql, (question_id, ))

        rows = cursor.fetchall() # 반환 값은 tuple (...)

        results = []   
        for row in rows:
            c = Choice(*row) # *(1, 2, 3) -> 1, 2, 3
            results.append(c)

        conn.close()

        return results

    def update_choice_votes(self, choice_id):
        conn = pymysql.connect(**self.connection_info)
        cursor = conn.cursor()

        sql = "update polls_choice set votes = votes + 1 where id = %s"
        cursor.execute(sql, (choice_id, ))

        conn.commit()
        
        conn.close()