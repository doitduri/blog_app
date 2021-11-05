# B.log 
사전과제 블로그 앱 입니다.  
Flutter + Firebase Cloud Firestore로 구현하였습니다.    
<br/>

<img src = "https://user-images.githubusercontent.com/26545623/140407192-8c3195c9-c38f-4868-a10d-45b5b41fbcab.gif" height="430">
  

![image](https://user-images.githubusercontent.com/26545623/140400690-d1375ea3-d5d3-49ec-87d1-3462cf71fe43.png)
<br/><br/>
## 주요 기능 및 설명
1. 글 쓰기
- wysiwyg(위지윅) 방식의 에디터로 글 작성 가능
- 이미지 삽입, 링크, 각종 마크다운 지원  

2. 글 삭제 및 수정
- 삭제/수정하고자 하는 글의 상세 페이지 진입 시 가능 

3. 댓글 쓰기 및 삭제
- 익명 기반 

4. 회원(미구현)
- 파이어베이스 인증을 이용하여 구현 시도 (코드만 있고, 작동은 안함)
<br/><br/>

## 사용 기술 및 설명
<img src = "https://user-images.githubusercontent.com/26545623/140407424-bf287fce-6855-49b4-a074-fea7bd28ae14.png" height="200">
<br/><br/><br/>

### 1. 백엔드
- Firebase Cloud Firestore 이용
- <img src = "https://user-images.githubusercontent.com/26545623/140408858-7284cc50-e8bb-4cec-a081-c3efb29913a9.png" height="200">
- 단일 테이블(Post)로 구현했습니다.
- NoSQL Database를 이번에 처음 사용해보았는데, 우선 간단하게 CRUD 정도만 하면 됐기에 사용하는데 큰 무리가 없을 것이라고 생각했습니다.
- 게시글에 대한 댓글의 생성/삭제/수정은 해당 Post 값 객체를 모두 update 하는 형식으로 로직을 구성하였습니다.
<br/>

### 2. 프론트엔드
- Flutter
- BLoC 패턴으로 상태관리   
<br/>

### 3. 이 기술들을 선택한 이유

- 저의 경우, 사전과제 공지 후 1주일이라는 시간이 있었지만 다른 일과 겹쳐서 시간 투자를 많이 할 수 없었습니다. 그래서 빠르게 과제에서 요구한 것들을 충족해야만 했기에 위와 같은 기술스택을 사용하게 되었습니다.
- 사실 다른 기술(Flask, Swift)로 먼저 만들어보았지만, 기한 내에 완료하기에 어렵다는 판단을 하였습니다.파이어베이스 스토리지 쪽은 처음 사용해보았지만, 플러터와 파이어베이스의 조합이 좋아서 정말 빠르게 원하는 기능을 만들 수 있어 인상적이었고, 만족스러운 결과물이 나왔습니다. 😇
<br/><br/>

## 알려진 버그
- [홈] 화면에서의 버튼 [최신 순] 과 [오래된 순] 대로 정렬되고 있지 않습니다.
<br/><br/>

## 전체 시연영상
https://user-images.githubusercontent.com/26545623/140443880-1cee96ae-9be0-4964-b96f-836761cfd829.MP4




