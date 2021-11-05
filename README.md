# B.log 
사전과제 블로그 앱 입니다.  
Flutter + Firebase Cloud Firestore로 구현하였습니다.    
<br/>

<img src = "https://user-images.githubusercontent.com/26545623/140407192-8c3195c9-c38f-4868-a10d-45b5b41fbcab.gif" height="430">
  

![image](https://user-images.githubusercontent.com/26545623/140400690-d1375ea3-d5d3-49ec-87d1-3462cf71fe43.png)
<br/><br/>
## 0. 주요 기능 및 설명
### 1. 글 쓰기
- wysiwyg(위지윅) 방식의 에디터로 글 작성 가능
- 이미지 삽입, 링크, 각종 마크다운 지원  

### 2. 글 삭제 및 수정
- 삭제/수정하고자 하는 글의 상세 페이지 진입 시 가능 

### 3. 댓글 쓰기 및 삭제
- 익명 기반 

### 4. 회원(미구현)
- 파이어베이스 인증을 이용하여 구현 시도 (코드만 있고, 작동은 안함)
<br/><br/><br/>

## 1. 사용 기술 및 설명
<img src = "https://user-images.githubusercontent.com/26545623/140407424-bf287fce-6855-49b4-a074-fea7bd28ae14.png" height="200">

### - 백엔드
- Firebase Cloud Firestore 이용  <br/>
### 글 정보(tb_posting_info)
|column|속성|설명|
|------|---|---|
|author||string|글쓴이|
|title|string|글 제목|
|content|string|글 내용(wysiwyg json)|
|planContent|string|글 내용(only text)|
|comment|array|글의 댓글|
|createAt|timestamp|생성일자|

- 단일 테이블(Post)로 구현했습니다.
- NoSQL Database를 이번에 처음 사용해보았는데, 우선 간단하게 CRUD 정도만 하면 됐기에 사용하는데 큰 무리가 없을 것이라고 생각했습니다.
- 게시글에 대한 댓글의 생성/삭제/수정은 해당 Post 값 객체를 모두 update 하는 형식으로 로직을 구성하였습니다.

### - 프론트엔드
- Flutter 2.5.3 / Dart 2.14.4
- BLoC 패턴으로 상태관리 (flutter_bloc ^7.3.1)
<br/><br/>

## 알려진 버그
- [홈] 화면에서의 버튼 [최신 순] 과 [오래된 순] 대로 정렬되고 있지 않습니다.
<br/><br/>

## 전체 시연영상
https://user-images.githubusercontent.com/26545623/140443880-1cee96ae-9be0-4964-b96f-836761cfd829.MP4




