import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../util/font.dart';

/// 뒤로가는 앱바
class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback onTap;

  BackAppBar({
    required this.text,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// 앱바 leading 기본 패딩 16, 23으로 맞추기 위해 왼쪽 패딩 추가
      leading:  Padding(
        padding: const EdgeInsets.only(left: 7),
        child: GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(
              'assets/icon/leftArrow.svg',
            fit: BoxFit.none,
          ),
        ),
      ),
      title: Text(
        text,
        style: f16gray900w700,
      ),
      backgroundColor: Colors.white,
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(44);
}
