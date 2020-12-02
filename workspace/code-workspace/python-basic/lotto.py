import random

cnt = input("Input Game Count : ")

for _ in range( int(cnt) ):

    numbers = []
    while True: # 무한 반복

        numbers.clear() # 기존에 뽑힌 숫자들을 제거

        while True:
            no = random.randint(1, 45) # 난수 추출
            if no in numbers: # 새로 뽑은 숫자가 이미 뽑힌 숫자와 중복되는 경우
                continue

            numbers.append(no)
            if len(numbers) == 6: # 6개의 숫자가 뽑힌 경우
                break

        total = 0
        for n in numbers:
            total += n

        avg = total / 6

        if avg >= 20 and avg <= 26: # 조건에 부합하는 평균값이라면 반복문 종료
            break

    numbers.sort()
    print( numbers, avg )