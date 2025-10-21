## 트립스토리 - 리팩토링 진행중
<img src="https://github.com/user-attachments/assets/37770302-aa61-4121-addc-3066043b45e9" width="100%">

# ✈️ 트립스토리 - 여행 계획 & 기록 앱


**트립스토리**는 여행의 계획부터 기록까지 여행의 전 과정을 함께하는 앱입니다.  

여행 성향(MBTI J형, P형)에 맞춘 템플릿으로 일정 계획을 쉽게 세우고

여행 중에는 실시간으로 일정을 관리하며, 여행 후에는 사진과 함께 추억을 기록할 수 있습니다.

---

## 🔗 배포 링크
- 앱스토어 배포 링크: [트립스토리 App Store](https://apps.apple.com/kr/app/%ED%8A%B8%EB%A6%BD%EC%8A%A4%ED%86%A0%EB%A6%AC/id6529530493)

---

## 🎨 프로젝트 아키텍처
Flutter로 구현된 본 프로젝트는 **Clean Architecture**를 기반으로 **GetX**를 활용한 **MVVM** 스타일의 구조를 따릅니다.

명확한 관심사 분리와 높은 유지보수성, 테스트 용이성을 목표로 설계되었습니다.

---

## 🛠️ 기술 스택

| Layer           | 기술/라이브러리          |
|-----------------|---------------------------|
| Framework       | Flutter (3.29.2)           |
| Language        | Dart                      |
| Architecture    | MVVM + Clean Architecture |
| 상태관리          | GetX                      |
| 네트워킹        | Retrofit (Dio 기반)          |

---

## ⚙️  클린 아키텍처 구성
### 1. Domain Layer
- **Entities**  
  앱의 핵심 비즈니스 모델을 정의합니다.  
  (ex. `TripRoomEntity`, `TripMemberEntity`)

- **Repositories (Interfaces)**  
  데이터 접근에 대한 추상화를 제공합니다.  
  (ex. `TripRepository`)

- **UseCases**  
  하나의 기능 단위를 담당하며 비즈니스 로직을 실행합니다.  
  (ex. `CreateTripRoomUseCase`)
### 2. Data Layer
- **RepositoryImpl**  
  Domain에서 정의한 Repository를 실제 구현합니다.  
  Remote DataSource와 통신하고 Mapper를 통해 데이터를 Entity로 변환해 전달합니다.  
  (ex. `TripRepositoryImpl`)
  
- **DataSource (Remote/Local)**  
  원격 데이터 소스와 연결하여 REST API를 호출합니다.  
  (ex. `TripDataSource`)
  
- **DTO → Entity 변환**  
  외부 데이터와 Domain Entity 간 변환을 담당합니다.  
  (ex. `TripRoomMapper`, `TripRoomCreateMapper`)
  
- **Model (DTO)**  
  API 통신에 사용하는 데이터 객체입니다.  
  (ex. `TripRoomResponse`, `TripRoomCreateRequest`)
### 3. Presentation Layer
- **View (Screen)**  
  실제 화면(UI)을 구성합니다.
- **Controller**  
  화면의 상태 관리와 UI 로직을 담당하며 UseCase를 호출해 데이터를 가져오고 UI에 반영합니다.  
  (ex. `TripRoomsCreateController`)
- **Binding**  
  GetX를 통해 Controller와 필요한 객체들의 의존성을 주입합니다.  
  (ex. `TripRoomsCreateBinding`)
- **Model (State)**  
  화면의 상태를 나타내는 데이터 모델입니다.  
  (ex. `TripRoomsState`, `TripRoomCreateState`)
- **Enum**  
  Presentation에서 UI 상태나 타입 구분에 사용됩니다.
---

## 🗂️ 디렉토리 구조 예시
```
lib/
  ├── common/
  ├── core/
  │     ├── constants/
  │     ├── errors/
  │     ├── logger/
  │     ├── network/
  │     ├── permission/
  │     ├── service/
  │     └── theme/
  ├── data/
  │     ├── datasources/
  │     │     ├── local/
  │     │     └── remote/
  │     ├── models/ 
  │     └── repositories/
  ├── domain/
  │     ├── usecases/ 
  │     ├── entities/
  │     └── repositories/
  ├── presentation/
  │     ├── home/
  │     │     ├── controller/
  │     │     ├── enums/
  │     │     ├── views/
  │     │     └── widgets/
  │     ├── trip/
  │     │     ├── controller/
  │     │     ├── enums/
  │     │     ├── views/
  │     │     └── widgets/
  │     ├── ...
  ├── utils/
  │     ├── helpers/
  │     └── extensions/
  └── main.dart
```
