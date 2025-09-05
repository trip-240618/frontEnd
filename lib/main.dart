import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/core/Injection/app_binding.dart';
import 'package:tripStory/core/constants/app_constants.dart';
import 'package:tripStory/core/router/router_info.dart';
import 'package:tripStory/core/theme/app_theme.dart';
import 'package:tripStory/presentation/global/global_context.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load();

  await Firebase.initializeApp();

  KakaoSdk.init(
    nativeAppKey: AppConstants.kakaoNativeAppKey,
    javaScriptAppKey: AppConstants.kakaoJavaScriptAppKey,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'tripStory',
      navigatorKey: GlobalContext.navigatorKey,
      supportedLocales: [
        Locale('ko', 'KR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialBinding: AppBinding(),
      initialRoute: "/",
      getPages: RouterInfo.config,
      theme: AppTheme.light,
    );
  }
}
