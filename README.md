# 고속도로 휴게소 식당 키오스크
## 개요
고속도로 휴게소에서 손님들이 사용하는 키오스크가 있어야 하고, 손님들이 주문한 내역을 주방에서 알 수 있게 해야 하고, 주문이 완료된 주문번호를 알려주어야 한다. 이러한 시스템을 구현한 프로그램이다. 


## 사용 기술
1. 자바스크립트
2. CSS 
3. JSP 
4. Web Socket 
5. Imgur API
6. Maria DB 
7. AJAX 

## 저작권(라이센스)
C-2021-020526

## 키오스크 프로그램 동작 과정
1. 회원가입을 한다.
2. 로그인 후 관리자 모드에 접속한다.
3. 관리자 모드에서 메뉴 이미지 선택, 이름, 가격을 입력한다.
4. 메뉴판 모드에 접속한다.
5. 메뉴판 페이지에서 주문한 음식 정보가 웹 소캣을 통해 주방 페이지에 전달된다.
6. 주방 페이지에서 완료된 음식은 클릭하여 삭제한다.
7. 주방 페이지에서 대기 번호를 송신 후 번호 페이지에서 대기 번호를 수신 한다.
8. 기록 페이지에서 월/일/시간 별로 총 수입을 알 수 있다.

## 페이지 이미지
### 로그인 페이지
![image](https://user-images.githubusercontent.com/74814641/134827217-69e5f5e2-4ee0-46bc-85d1-95f76ae9ef4c.png)

### 모드 선택 페이지
![image](https://user-images.githubusercontent.com/74814641/229352053-c0a1a3f9-814a-4a07-92fe-9bc457dbd9f3.png)

### 주방 페이지
![image](https://user-images.githubusercontent.com/74814641/134827287-5c676ad5-c6c1-40f7-b0de-f8d14460ff6d.png)

### 메뉴판 페이지
![image](https://user-images.githubusercontent.com/74814641/134827321-f9c1d0fc-34fc-4431-9468-e25dce66859e.png)

### 장바구니 페이지
![image](https://user-images.githubusercontent.com/74814641/134827352-6ec0e236-ba89-4b22-a4a1-99cca7a11957.png)

### 번호 페이지
![image](https://user-images.githubusercontent.com/74814641/229352616-5a4890e8-e770-4ba4-a5ce-acb7300a850c.png)


### 관리자 페이지
![image](https://user-images.githubusercontent.com/74814641/134827414-a71b8b75-526c-4534-9cb7-371f27c8c994.png)

## 기능 설명(영상)
### 주요 기능
1. 회원가입 
2. ID찾기
3. PW찾기
4. 메뉴 주문
5. 주문한 메뉴 주방 페이지에 출력
6. 관리자 모드에서 메뉴 관리 및 매출 관리

### 회원가입 - ID 중복체크는 AJAX를 이용하여 구현, 비밀번호 형식체크 구현
https://user-images.githubusercontent.com/74814641/134828356-b673c53a-8ea1-4cf1-8735-ff275a76b8cd.mp4

### ID찾기 
https://user-images.githubusercontent.com/74814641/134828491-5ff9cee0-eee1-415f-9e29-28ac2c6cfc4c.mp4

### PW찾기
https://user-images.githubusercontent.com/74814641/134828536-885bbfc5-9336-4c42-a222-a37572e1601a.mp4

### 관리자 모드 - IMGUR API를 통해 이미지를 DB에 저장
https://user-images.githubusercontent.com/74814641/134828773-1a6e20a6-bbb2-4df1-a1b9-48920209b3a4.mp4

### 메뉴 주문 및 주방 페이지 전달 - 웹 소캣을 통해 메뉴판 페이지와 주방 페이지 송수신
https://user-images.githubusercontent.com/74814641/134828956-5746ab0f-b224-4086-b80f-aa0b8dfd3b46.mp4

### 매출 관리 - 년/월/일 별로 매출 
https://user-images.githubusercontent.com/74814641/134829217-caffc4cb-60d9-473b-9579-b50a6d23143c.mp4


시연영상
https://youtu.be/vh9ZiJ5MH9I
