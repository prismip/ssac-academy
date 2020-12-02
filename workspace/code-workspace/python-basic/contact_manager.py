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

def input_contact():
    # 입력
    global next_no # 이 변수는 현재 함수의 지역 변수가 아니라 외부 변수입니다.
    name = input("이름을 입력하세요: ")
    phone = input("전화번호를 입력하세요: ")
    email = input("이메일을 입력하세요: ")
    no = next_no
    next_no += 1
    contact = { 'no': no, 'name' : name, 'phone': phone, 'email': email }
    return contact

def show_contacts(contacts):
    if len(contacts) == 0:
        print('등록된 연락처가 없습니다.')
        return # 함수를 즉시 종료하는 명령

    print("[ 연락처 목록 ]")
    for c in contacts:
        print("[{0}][{1}][{2}][{3}]".format(c['no'], c['name'], c['email'], c['phone']))

def search_contacts():
    # 검색 결과를 저장할 리스트 만들기
    searched_result = []
    # 입력 (이름입력)
    name = input('검색할 연락처 이름 : ')
    # 연락처 목록을 순회하면서 입력받은 이름과 일치하는 이름의 연락처 찾기   abc == abc / abc == a~, ~b~
    # 찾은 연락처를 검색 결과 리스트에 추가
    for c in contacts:
        # if name == c['name']: # 완전 일치 검색
        if name in c['name']: # 부분 일치 검색
            searched_result.append(c)

    return searched_result

def delete_contact(no_to_delete):
    # 삭제 - 목록을 순회하면서 일치하는 번호의 연락처 삭제
    for c in contacts:
        if c['no'] == no_to_delete:
            contacts.remove(c)
            return True # 삭제 성공

    return False # 삭제 실패

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
            contact = input_contact()
            contacts.append(contact)

        elif selected_no == 3: # 삭제 선택
            # 삭제를 위한 검색
            searched_result = search_contacts()
            if len(searched_result) == 0:
                print("검색 실패")
            else:
                # 검색 결과 표시
                print("[ 삭제 대상 연락처 목록 ]")
                show_contacts(searched_result)

                # 삭제 대상 선택 (사용자 입력 - 번호)
                no = input('삭제할 연락처의 번호 : ')
                no = int(no)
                
                success = delete_contact(no)
                if success:
                    print("삭제했습니다.")
                else:
                    print("삭제 실패")

        elif selected_no == 4: # 목록 보기
            show_contacts(contacts)

        elif selected_no == 5: # 검색
            
            searched_result = search_contacts()
            # 검색 결과 리스트를 출력
            show_contacts(searched_result)

        else:
            print("작업 준비중..")


do_manage()

