def func(x):
    assert type(x) == int, "전달인자의 자료형이 정수가 아닙니다."
    return x * 10

result = func('hello')

print(result)