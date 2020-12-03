# 연락처 관리 프로그램
# 기능 : 생성(C), 조회(R), 수정(U), 삭제(D) -> CRUD
# 연락처 데이터 내용 : 번호(자동증가처리), 이름, 전화번호, 이메일
# 연락처 데이터 형식 : 리스트 or 딕셔너리 -> 딕서너리 사용 -> { "no": 1, "name": 'id', "email": 'e', "phone": 'p' }

class Contact:
    '연락처 정보를 저장하는 클래스'

    def __init__(self, no, name, email, phone):
        self.no = no
        self.name = name
        self.email = email
        self.phone = phone

    def to_dict(self):
        return { 'no': self.no, 'name': self.name, 'email': self.email, 'phone': self.phone }

    def contact_info(self):
        return "[{0}][{1}][{2}][{3}]".format(self.no, self.name, self.email, self.phone)

class ContactManager:

    def __init__(self):
        self.next_no = 1        # 자동 증가 번호를 관리하는 변수
        self.contacts = []      # 연락처 딕셔너리의 목록을 관리하는 변수

    def show_menu(self):
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

    def input_contact(self):
        name = input("이름을 입력하세요: ")
        phone = input("전화번호를 입력하세요: ")
        email = input("이메일을 입력하세요: ")
        no = self.next_no
        self.next_no += 1
        # contact = { 'no': no, 'name' : name, 'phone': phone, 'email': email }
        # c = Contact(**contact)
        contact = Contact(no, name, email, phone)
        return contact

    def show_contacts(self, contacts=None):

        if contacts == None:
            contacts = self.contacts

        if len(contacts) == 0:
            print('표시할 연락처가 없습니다.')
            return # 함수를 즉시 종료하는 명령

        print("[ 연락처 목록 ]")
        for c in contacts:
            # print("[{0}][{1}][{2}][{3}]".format(c['no'], c['name'], c['email'], c['phone']))
            # print("[{no}][{name}][{email}][{phone}]".format(no=c['no'], name=c['name'], email=c['email'], phone=c['phone']))
            # print("[{no}][{name}][{email}][{phone}]".format(**c))
            print(c.contact_info())

    def search_contacts(self):
        # 검색 결과를 저장할 리스트 만들기
        searched_result = []
        # 입력 (이름입력)
        name = input('검색할 연락처 이름 : ')
        # 연락처 목록을 순회하면서 입력받은 이름과 일치하는 이름의 연락처 찾기   abc == abc / abc == a~, ~b~
        # 찾은 연락처를 검색 결과 리스트에 추가
        for c in self.contacts:
            # if name == c['name']: # 완전 일치 검색
            if name in c.name: # 부분 일치 검색
                searched_result.append(c)

        return searched_result

    def delete_contact(self, no_to_delete):
        # 삭제 - 목록을 순회하면서 일치하는 번호의 연락처 삭제
        for c in self.contacts:
            if c.no == no_to_delete:
                self.contacts.remove(c)
                return True # 삭제 성공

        return False # 삭제 실패

    def do_manage(self):
        '연락처 관리 메인 로직 구현 메서드'

        while True:

            # 사용자에게 선택할 수 메뉴 표시 -> 사용자 선택
            selected_no = self.show_menu()

            # 사용자 선택에 따라 기능 수행
            if selected_no == 0: # 종료 선택
                print("프로그램을 종료합니다.")
                break

            elif selected_no == 1: # 등록 선택
                contact = self.input_contact()
                self.contacts.append(contact)

            elif selected_no == 3: # 삭제 선택
                # 삭제를 위한 검색
                searched_result = self.search_contacts()
                if len(searched_result) == 0:
                    print("검색 실패")
                else:
                    # 검색 결과 표시
                    print("[ 삭제 대상 연락처 목록 ]")
                    self.show_contacts(searched_result)

                    # 삭제 대상 선택 (사용자 입력 - 번호)
                    no = input('삭제할 연락처의 번호 : ')
                    no = int(no)
                    
                    success = self.delete_contact(no)
                    if success:
                        print("삭제했습니다.")
                    else:
                        print("삭제 실패")

            elif selected_no == 4: # 목록 보기
                self.show_contacts()

            elif selected_no == 5: # 검색
                
                searched_result = self.search_contacts()
                # 검색 결과 리스트를 출력
                self.show_contacts(searched_result)

            else:
                print("작업 준비중..")

# print(__name__)
if __name__ == "__main__":
    cm = ContactManager()
    cm.do_manage()