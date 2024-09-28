import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TooltipShape extends ShapeBorder {
  const TooltipShape({
    this.borderColor = Colors.black,
    this.borderWidth = 2.0, // 기본 보더 두께를 2로 설정
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)), // 각 모서리에 4의 반경 추가
  });

  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    path.addRRect(
      borderRadius.resolve(textDirection).toRRect(rect).deflate(borderWidth),
    );
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final RRect rrect = borderRadius.resolve(textDirection).toRRect(rect);
    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = borderRadius.resolve(textDirection).toRRect(rect);

    // 화살표 부분을 포함한 경로
    path.moveTo(53 + borderWidth, borderWidth); // 화살표 오른쪽 상단에서 시작
    path.lineTo(43 + borderWidth, -10); // 화살표의 뾰족한 부분
    path.lineTo(33 + borderWidth, borderWidth); // 화살표 왼쪽 상단
    path.lineTo(borderWidth + 10, borderWidth); // 화살표 왼쪽 상단

    // 왼쪽 상단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(borderWidth, borderWidth, borderWidth, 4 + borderWidth);

    // 왼쪽 세로 직선
    path.lineTo(borderWidth, rrect.height - 4 - borderWidth);

    // 왼쪽 하단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(borderWidth, rrect.height - borderWidth, 4 + borderWidth, rrect.height - borderWidth);

    // 하단 직선
    path.lineTo(rrect.width - 4 - borderWidth, rrect.height - borderWidth);

    // 오른쪽 하단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(rrect.width - borderWidth, rrect.height - borderWidth, rrect.width - borderWidth, rrect.height - 4 - borderWidth);

    // 오른쪽 세로 직선
    path.lineTo(rrect.width - borderWidth, 4 + borderWidth);

    // 오른쪽 상단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(rrect.width - borderWidth, borderWidth, rrect.width - 4 - borderWidth, borderWidth);

    // 상단 직선
    path.lineTo(53 + borderWidth, borderWidth);

    return path;
  }

  @override
  ShapeBorder scale(double t) => TooltipShape(
    borderColor: borderColor,
    borderWidth: borderWidth * t,
    borderRadius: BorderRadius.all(Radius.circular(4.0)), // BorderRadius 스케일링
  );
}