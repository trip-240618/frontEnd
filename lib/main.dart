import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tripStory/screen/splashScreen.dart';
import 'package:tripStory/screen/login/loginPage.dart';
import 'package:tripStory/screen/login/register/term.dart';
import 'package:tripStory/screen/trip/bottomNavigator.dart';
import 'package:tripStory/screen/trip/tripPlan/typeJ/addPlan/searchFlight.dart';
import 'package:tripStory/screen/trip/setting/trip_edit_page.dart';
import 'imageTest.dart';


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(); // Firebase 초기화
  KakaoSdk.init(
    nativeAppKey: '39c88180cf07b71dc3e44c8b41822afa',
    javaScriptAppKey: '401159aa34400f2b53f252d9f4448744',
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
      title: 'Flutter Demo',
        supportedLocales: [
          Locale('ko', 'KR'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white,surfaceTintColor: Colors.white)
      ),
      home: SplashPage(),
      // home: TermPage(),
    );
  }
}

