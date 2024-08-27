# acote

<p align="center">
<img width="200" alt="7" src="https://github.com/user-attachments/assets/f4238a64-7ad3-4002-877d-eb62193a1552">
<img width="200" alt="7" src="https://github.com/user-attachments/assets/1d3858e9-26fc-4743-8508-5eb91fa79891">
<img width="200" alt="7" src="https://github.com/user-attachments/assets/270fad64-8f66-46dd-afbd-e14aee79441f">
</p>

### 프로젝트 빌드 및 실행 방법

1. Visual Studio Code에서 Flutter와 Dart 플러그인을 설치합니다.
2. 터미널을 열어 기존 프로젝트를 클론합니다.
```
git clone https://github.com/SloWax/Acote.git
```
3. Visual Studio Code에서 해당 프로젝트를 열고 pubspec.yaml로 이동하여 Get Packages 버튼을 눌러 패키지를 설치합니다.
4. Visual Studio Code 하단의 상태 표시줄에서 빌드할 디바이스를 선택합니다.
5. main.dart 파일로 이동하여 F5 키를 누르거나, VS Code 상단의 Run > Start Debugging을 클릭하여 프로젝트를 빌드하고 실행합니다.

### 주요 설계 결정
- Provider
	- 프로젝트의 복잡도가 낮기 때문에 Provider를 사용하여 간단하고 직관적인 상태 관리를 구현했습니다.
- 페이지네이션
	- GitHub API의 페이지네이션 기능을 사용하여 사용자 목록을 동적으로 로드합니다.
	- 스크롤이 끝에 도달하기 300pixel전 미리 다음 페이지 데이터를 불러오도록 설정해 스크롤이 끊기는 장면을 최소화 했습니다.

- Pull to Refresh
	- RefreshIndicator 위젯을 사용하여 리스트를 아래로 당기면 데이터를 새로고침할 수 있는 기능을 추가했습니다.

- 광고 배너
	- 10번째, 20번째, 30번째 항목마다 광고 배너를 삽입하여 사용자가 광고를 볼 수 있도록 했습니다.

### 상태 관리 방법 선택 이유
Provider는 Flutter에서 가장 많이 사용되는 상태 관리 방법으로, 간단한 상태 관리 및 데이터 공유가 필요한 경우에 적합합니다.
이 프로젝트에서는 HomeVM과 DetailVM을 사용하여 유저 목록과 Repository 목록, API 통신 상태를 관리했습니다.
Bloc 패턴 고려 하였으나 이 프로젝트의 복잡도가 낮아 Provider로 충분히 상태 관리를 할 수 있다고 판단했습니다.
