import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showCustomToast(BuildContext context, FToast fToast, String text) {
  fToast.showToast(
    child: Container(
      width: MediaQuery.of(context).size.width,  // 화면 너비 가져오기
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xff212121).withOpacity(0.7),  // 반투명한 배경
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 9,
          ),
          BoxShadow(
            color: Color(0x17000000),
            offset: Offset(0, 16),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 36),
            blurRadius: 21,
          ),
          BoxShadow(
            color: Color(0x03000000),
            offset: Offset(0, 63),
            blurRadius: 25,
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icon/copy.svg',
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text(
              '${text}',
              style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),  // f14whitew600 스타일 인라인 적용
            ),
          ],
        ),
      ),
    ),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
    positionedToastBuilder: (context, child) {
      return Positioned(
        bottom: 100.0, // 바텀에서 50px 패딩 적용
        left: 20,
        right: 20,
        child: child,
      );
    },
  );
}
