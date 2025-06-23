import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/util/color.dart';

import '../util/font.dart';

/// 뒤로가는 앱바
class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final VoidCallback onTap;
  final Color? color;

  BackAppBar({
    this.text,
    required this.onTap,
    this.color = gray50,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// 앱바 leading 기본 패딩 16, 20으로 맞추기 위해 왼쪽 패딩 추가
      leading: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            'assets/icon/left_arrow.svg',
            fit: BoxFit.none,
          ),
        ),
      ),
      title: Text(
        text ?? "",
        style: f18Gray900w600,
      ),
      backgroundColor: color,
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
  final Color? color;

  TrailingBackAppBar({
    required this.text,
    required this.backTap,
    required this.svgPicture,
    required this.trailingTap,
    this.color = gray50,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// 앱바 leading 기본 패딩 16, 20으로 맞추기 위해 왼쪽 패딩 추가
      leading: GestureDetector(
        onTap: backTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            color: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icon/left_arrow.svg',
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
      title: Text(
        text,
        style: f18Gray900w600,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: trailingTap,
            borderRadius: BorderRadius.circular(100),
            child: Container(width: 30, height: 30, child: svgPicture),
          ),
        )
      ],
      backgroundColor: color,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(44);
}

/// 팝업메뉴 앱바
class popupBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final PopupMenuButton popupMenuButton;
  final Color? color;

  popupBackAppBar({
    required this.text,
    required this.popupMenuButton,
    this.color = gray50,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// 앱바 leading 기본 패딩 16, 20으로 맞추기 위해 왼쪽 패딩 추가
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            color: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icon/left_arrow.svg',
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
      title: Text(
        text,
        style: f18Gray900w600,
      ),
      actions: [Padding(padding: const EdgeInsets.only(right: 20), child: popupMenuButton)],
      backgroundColor: color,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(44);
}
