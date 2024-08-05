import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInDemo extends StatefulWidget {
  @override
  _GoogleSignInDemoState createState() => _GoogleSignInDemoState();
}

class _GoogleSignInDemoState extends State<GoogleSignInDemo> {

  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      await _initGoogle();
    });
  }

  /// 구글데이터 보내기
  Future<void> googleSendData() async {
    final url = 'https://trip-story.site/user/oauth2/login/google';

    // Extract data from _currentUser
    final _currentUser = this._currentUser;
    if (_currentUser != null) {

      final userData = {
        "displayName": "${_currentUser.displayName}",
        "email": "${_currentUser.email}",
        "id": "${_currentUser.id}",
        "photoUrl": "${_currentUser.photoUrl}",
        "serverAuthCode": "${_currentUser.serverAuthCode}"
      };
      // Send the data as a JSON payload
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      // print('Response status: ${response.statusCode}');
      // print('?? ${response.headers}');
      // print('Response body: ${response.body}');
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<void> _initGoogle()async{
    /// 구글로그인이 리스너 -> 값이 변화하면 찍힘
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print('?? ${account}');
      setState(() {
        _currentUser = account;
      });
    });
    /// 앱 시작 시 자동 로그인 시도
    _googleSignIn.signInSilently().then((account) {
      print('자동로그인');
      print('?? ${account}');
      setState(() {
        _currentUser = account;
      });
    }).catchError((error) {
      // 자동 로그인 실패 시 처리할 작업
      print('자동 로그인 실패: $error');
    });
  }
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value)async{
        _currentUser = value;
        await googleSendData();
        setState(() {});
      });

    } catch (error) {
      print(error);
    }
  }
  Future<void> _handleSignOut() async {
    // 로그아웃 시 disconnect() 메서드 사용
    await _googleSignIn.disconnect();
    setState(() {
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Demo'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            user != null
                ? Column(
                children: <Widget>[
                ListTile(
                  leading: GoogleUserCircleAvatar(identity: user),
                  title: Text(user.displayName ?? ''),
                  subtitle: Text(user.email),
                ),
                ElevatedButton(
                  onPressed: _handleSignOut,
                  child: Text('로그아웃'),
                ),
              ],
            )
                : ElevatedButton(
                  onPressed: _handleSignIn,
                  child: Text('구글로 로그인'),
            ),
          ],
        ),
      ),
    );
  }
}