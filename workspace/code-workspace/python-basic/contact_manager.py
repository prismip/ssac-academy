# 연락처 관리 프로그램
# 기능 : 생성(C), 조회(R), 수정(U), 삭제(D) -> CRUD
# 연락처 데이터 내용 : 번호(자동증가처리), 이름, 전화번호, 이메일
# 연락처 데이터 형식 : 리스트 or 딕셔너리 -> 딕서너리 사용 -> { "no": 1, "name": 'id', "email": 'e', "phone": 'p' }


next_no = 1 # 자동 증가 번호를 관리하는 변수
contacts = [] # 연락처 딕셔너리의 목록을 관리하는 변수

def show_menu():
    print("*" * 30)
    print("* 1. 연락처 등록. ")
    print("* 2. 연락처 수정. ")
    print("* 3. 연락처 삭제. ")
    print("* 4. 연락처 목록보기. ")
    print("* 5. 연락처 검색. ")
    print("* 0. 종료 ")
    print("*" * 30)
    selected_no = input("SELECT MENU NO : ")
    return int(selected_no)

def do_manage():
    '연락처 관리 메인 로직 구현 메서드'

    while True:

        # 사용자에게 선택할 수 메뉴 표시 -> 사용자 선택
        selected_no = show_menu()

        # 사용자 선택에 따라 기능 수행
        if selected_no == 0: # 종료 선택
            print("프로그램을 종료합니다.")
            break

        elif selected_no == 1: # 등록 선택
            # 입력
            name = input("이름을 입력하세요: ")
            phone = input("전화번호를 입력하세요: ")
            email = input("이메일을 입력하세요: ")
            contact = { 'no': 1, 'name' : name, 'phone': phone, 'email': email }
            pass

        else:
            print("작업 준비중..")


do_manage()

