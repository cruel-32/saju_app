# 봄(Borium) 앱 실행 방법

## 가장 쉬운 방법: `run.bat`

프로젝트 루트에서 더블클릭하거나 터미널에서:

```bash
run.bat          # Windows 데스크톱 앱으로 실행 (기본값)
run.bat chrome   # 웹 브라우저(Chrome)로 실행
run.bat edge     # 웹 브라우저(Edge)로 실행
```

`run.bat`은 `C:\flutter\bin\flutter.bat`가 있으면 그걸 우선 사용하고, 없으면 PATH의 `flutter`를 그대로 쓴다. 이 PC처럼 Flutter SDK가 한글 경로에 있어서 생기는 문제(아래 "주의할 점" 참고)를 신경 쓰지 않아도 되고, 다른 PC에 그대로 복사해서 써도 안전하다.

## 사전 준비

- Flutter SDK 설치 확인: `flutter --version` (현재 환경: Flutter 3.47.9, Dart 3.13.7)
- 의존성 설치: 프로젝트 루트(`flutter_application`)에서

  ```bash
  flutter pub get
  ```

## ⚠️ 이 PC에서 주의할 점: Flutter SDK 경로에 한글이 있으면 빌드가 깨진다

이 머신에는 Flutter SDK가 두 곳에 설치되어 있다.

- `C:\Users\최승희IT2489\works\flutter\flutter` — 사용자 PATH에서 먼저 잡히는 경로(한글 포함)
- `C:\flutter` — ASCII 경로의 SDK

`flutter` 명령이 한글 경로의 SDK로 실행되면, 프레임워크 내장 셰이더(`ink_sparkle.frag`)를 컴파일하는 `impellerc.exe`가 **SIGSEGV로 즉시 죽어서** Windows 데스크톱 빌드와 웹(Chrome/Edge) 빌드가 모두 실패한다(`ShaderCompilerException`). 원인은 프로젝트 경로가 아니라 impellerc가 읽어들이는 SDK 내부 셰이더 소스 경로에 한글이 섞여 있기 때문이다 — ASCII 경로로 테스트했을 때는 정상 컴파일됐다.

**해결책**: `flutter` 명령을 호출할 때 `C:\flutter\bin\flutter`를 명시적으로 쓰거나, PATH에서 `C:\flutter\bin`을 한글 경로보다 앞에 두면 된다.

```bash
# PATH 순서를 바꾸지 않고 바로 이 SDK로 실행하는 가장 간단한 방법
/c/flutter/bin/flutter run -d windows
```

아래의 모든 `flutter ...` 명령은 이 PC에서는 `/c/flutter/bin/flutter ...` (또는 `C:\flutter\bin\flutter.bat ...`)로 바꿔서 실행해야 한다.

## 실행 가능한 디바이스 확인

```bash
flutter devices
```

이 머신에서는 다음 타깃이 잡힙니다.

- `windows` — Windows 데스크톱 앱
- `chrome` — 웹 브라우저(Chrome)
- `edge` — 웹 브라우저(Edge)

## 실행

프로젝트 루트(`flutter_application`)에서 아래 명령 중 하나를 실행합니다.

```bash
# Windows 데스크톱 앱으로 실행 (실제 창이 뜸)
flutter run -d windows

# 웹 브라우저(Chrome)로 실행
flutter run -d chrome

# 웹 브라우저(Edge)로 실행
flutter run -d edge
```

- 최초 실행 시 Windows 빌드는 CMake 구성 + 컴파일 때문에 다소 시간이 걸립니다(수 분 소요 가능). 이후 실행은 캐시 덕분에 빠릅니다.
- 실행 중 터미널에서 `r`을 누르면 Hot Reload, `R`을 누르면 Hot Restart, `q`를 누르면 종료됩니다.
- VS Code / Android Studio를 쓴다면 디바이스 선택 드롭다운에서 `Windows (desktop)`을 고르고 F5(Run) 하는 것도 동일합니다.

## 빌드만 하고 싶을 때 (배포용)

```bash
flutter build windows
```

빌드 결과물은 `build/windows/x64/runner/Release/` 아래에 생성됩니다.

## 참고

- 앱 엔트리 포인트: `lib/main.dart`
- 앱 구조/라우팅: `lib/app/app.dart`, `lib/app/routes.dart`
- 홈 화면: `lib/features/home/home_screen.dart`
