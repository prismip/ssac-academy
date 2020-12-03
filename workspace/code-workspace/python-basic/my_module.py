
print('this is my_module')

x = 100

def add(*args):
    total = 0
    for d in args:
        total += d

    return total

print(__name__)

if __name__ == '__main__':
    print(add(10, 20, 30, 40, 50))