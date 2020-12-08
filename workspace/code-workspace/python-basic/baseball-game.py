# 프로그램 : 숫자 만들어서 숨김 (3개)
# 사용자가 숫자를 제시 (3개) -> 상태 반환 -> 숫자 제시 -> 상태 반환
# 상태 반환 :  (S : 숫자와 위치가 일치, B : 숫자는 일치 / 위치는 다른 경우, O : 숫자가 없는 경우)
# 상태 반환 :  3S이면 사용자 승리, 지정된 횟수 초과하면 프로그램이 승리

import random

class BaseballGame:
    """
    야구 게임을 구현한 클래스
    """

    def __init__(self): # 초기화 함수 -> BaseballGame()으로 인스턴스를 만들 때 자동 호출
        pass

    def make_hidden_numbers(self):
        # 숫자 만들어서 숨기기
        hidden_numbers = []
        while len(hidden_numbers) < 3:
            number = random.randint(0, 9)
            if number in hidden_numbers:
                continue
            hidden_numbers.append(number)

        return hidden_numbers # 호출한 곳으로 hidden_numbers를 반환

    def input_user_numbers(self):
        while True:
            line = input('Your Numbers (ex : 1, 2, 3): ')
            user_numbers = line.split(',')
            if len(user_numbers) == 3:
                try:
                    user_numbers =[ int(n.strip()) for n in user_numbers ] # strip : 문자열 양 끝의 공백 제거
                except:
                    print('Invalid input !!!')
                    print("Input Format : 1, 2, 3")
                else: # 예외가 발생하지 않은 경우에만 실행
                    return user_numbers 
            else:
                print('Invalid input !!!')
                print("Input Format : 1, 2, 3")

    def check_user_numbers(self, hidden_numbers):
        pass
    
    def start_game(self):

        # 숫자 만들어서 숨기기
        hidden_numbers = self.make_hidden_numbers()
        print("HIDDEN_NUMBERS : ", hidden_numbers)

        for idx in range(1, 11):
            pass
            # 사용자 입력
            user_numbers = self.input_user_numbers()
            print("USER NUMBERS : ", user_numbers)

            # # 상태 반환
            # strike_count, ball_count, out_count = self.check_user_numbers(user_numbers)

            # # 상태 출력
            # print("[STRIKE : {0}][BALL : {1}][OUT : {2}".format(strike_count, ball_count, out_count))

            # # 다음 처리 결정 (사용자 승리 선언 - 게임 중단) - break
            # if strike_count == 3:
            #     print("Congratulations !!!!!")
            #     print("You Win !!!!!")
            #     break
        else:
            # 다음 처리 결정 (프로그램 승리 선언 - 게임 중단)
            print("You Lose !!!!!")
            

if __name__ == "__main__": # 현재 모듈을 python module-name.py 방식으로 실행한 경우 (import 한 경우에는 실행하지 마세요)
    game = BaseballGame()
    game.start_game()
