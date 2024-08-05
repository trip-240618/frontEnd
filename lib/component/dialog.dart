import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 메세지만 있는 확인용 다이얼로그
showConfirmTapDialog(
    BuildContext context){
  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.only(top: 40,bottom: 25),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: 350,
          child: Text('에러가 감지되었습니다 잠시후 다시 접속해주세요',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: (){
              SystemNavigator.pop();
            },
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  '확인',
                ),
              ),
            ),
          ),
        )
      ],
    );
  });
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.only(top: 40,bottom: 25),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: 350,
          child: Text('잠시후 다시 접속해주세요',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        Center(
          child: GestureDetector(
            onTap: (){
              if(Platform.isAndroid){
                SystemNavigator.pop();
              }else{
                exit(0);
              }
            },
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  '확인',
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
