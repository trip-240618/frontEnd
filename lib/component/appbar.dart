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
          child: Container(
            color: Colors.transparent,
            child: SvgPicture.asset(
                'assets/icon/leftArrow.svg',
              fit: BoxFit.none,
            ),
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

/// 뒤로가는 앱바에 Trailing 아이콘도 있을 경우
class TrailingBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback backTap;
  final SvgPicture svgPicture;
  final VoidCallback trailingTap;

  TrailingBackAppBar({
    required this.text,
    required this.backTap,
    required this.svgPicture,
    required this.trailingTap,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// 앱바 leading 기본 패딩 16, 23으로 맞추기 위해 왼쪽 패딩 추가
      leading:  Padding(
        padding: const EdgeInsets.only(left: 7,),
        child: GestureDetector(
          onTap: backTap,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: trailingTap,
            child: svgPicture,
          ),
        )
      ],
      backgroundColor: Colors.white,
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(44);
}
