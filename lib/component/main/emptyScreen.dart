import 'package:flutter/material.dart';

import '../../util/font.dart';

Widget EmptyScreen(BuildContext context) {
  return Expanded(
    child: Container(
        child: Center(child: Text('새 여행을 등록해 보세요',style: f24gray400w700,))),
  );
}