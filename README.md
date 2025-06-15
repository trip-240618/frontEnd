
![Untitled](https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/mainImage.png?alt=media)

# 트립스토리 (TirpStory)
> “여행 계획 세우는 거,,, 왜 이렇게 힘든 거야!!!”
> 
> “일정 짜려고 하니까 어디부터 시작해야 할지 모르겠고,,, 머리만 아프네,,,”
> 
> “모두가 만족할 만한 일정은 어떻게 만들지?”


트립스토리라면 이런 고민 한 방에 해결!
내 여행 스타일에 맞는 템플릿, 친구들과 함께 만드는 일정 그리고 추억을 간직할 기록 관리까지!

**지금 바로 트립스토리에서 간편하게 여행을 시작해보세요! 🚀✨**

## 🎨 주요 기능

## 🛠 기술 스택

<img class="badge" src="https://img.shields.io/badge/Flutter-3.24.0-blue"> <img class="badge" src="https://img.shields.io/badge/dart-3.5.0-blue">

## 배포 링크
- 앱스토어 배포 링크: [https://trip-story.site/swagger-ui/index.html#/](https://trip-story.site/swagger-ui/index.html#/)
- 플레이스토어 배포 링크: [https://trip-story.site/swagger-ui/index.html#/](https://trip-story.site/swagger-ui/index.html#/)


## 📚 Libraries
| 라이브러리                  | Version     | 
| ---------------------------- | :-----:  |
| kakao_flutter_sdk            | `1.9.3`  |
| sign_in_with_apple           | `6.1.1`  |
| google_sign_in               | `6.2.1`  |
| stomp_dart_client            | `2.0.0`  |
| flutter_jailbreak_detection  | `1.10.0` |
| get                          | `4.6.6`  |
| firebase_messaging           | `15.0.3` |
| flutter_local_notifications  | `17.2.1+1` |
| google_maps_flutter          | `2.6.0`  |
| google_places_flutter        | `2.0.9` |
| flutter_quill                | `10.4.5` |
| flutter_quill_extensions     | `10.4.5` |
| connectivity_plus            | `6.1.1` |
| google_maps_cluster_manager_2| `3.2.0` |
| flutter_cache_manager        | `3.4.1` |

## 🗂 폴더 구조
```

lib/
  ├── app/
  │     ├── injection/
  │     ├── router/
  │     └── themes/
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
  │     ├── common/
  │     ├── home/
  │     │     ├── controllers/
  │     │     ├── enums/
  │     │     ├── views/
  │     │     └── widgets/
  │     ├── login/
  │     │     ├── controllers/
  │     │     ├── enums/
  │     │     ├── views/
  │     │     └── widgets/
  ...
  ├── utils/
  │     ├── helpers/
  │     ├── constants/
  │     └── extensions/
  └── main.dart

```
