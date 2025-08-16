import 'package:flutter/material.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class JPlanListTile extends StatelessWidget {
  final String startTime;
  final String title;
  final String? memo;
  final Color labelColor;
  final VoidCallback? onTap;
  final Widget? trailing;

  const JPlanListTile({
    super.key,
    required this.startTime,
    required this.title,
    this.memo,
    required this.labelColor,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Container(
              width: 58,
              decoration: BoxDecoration(
                color: context.color.gray200,
                border: Border.all(color: context.color.gray200),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              child: Center(
                child: Text(
                  startTime,
                  style: context.style.caption1,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.color.gray200),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (memo != null && memo!.isNotEmpty)
                        _MemoPopupMenu(
                          memo: memo!,
                          color: labelColor,
                        ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          title,
                          style: context.style.caption1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing ?? SizedBox(height: 50)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemoPopupMenu extends StatelessWidget {
  final String? memo;
  final Color color;

  const _MemoPopupMenu({
    required this.memo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (memo == null || memo!.isEmpty) return const SizedBox();

    return PopupMenuButton(
      offset: const Offset(-35, 45),
      shadowColor: context.color.black.withValues(alpha: 0.4),
      shape: _TooltipShape(borderColor: color),
      color: context.color.white,
      itemBuilder: (_) => [
        PopupMenuItem(
          enabled: false,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            memo!,
            style: context.style.caption1.copyWith(
              color: color,
            ),
          ),
        ),
      ],
      child: SvgIcon(
        assetPath: IconConstants.memo,
        color: color,
      ),
    );
  }
}

class _TooltipShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;

  static const double arrowHeight = 10.0;
  static const double arrowPosition = 43.0;

  const _TooltipShape({
    required this.borderColor,
    this.borderWidth = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  ShapeBorder scale(double t) {
    return _TooltipShape(
      borderColor: borderColor,
      borderWidth: borderWidth * t,
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final rRect = borderRadius.resolve(textDirection).toRRect(rect);
    return Path()..addRRect(rRect.deflate(borderWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final rrect = borderRadius.resolve(textDirection).toRRect(rect);
    final width = rrect.width;
    final height = rrect.height;

    final path = Path();

    // 화살표
    path.moveTo(arrowPosition + borderWidth + 10, borderWidth);
    path.lineTo(arrowPosition + borderWidth, -arrowHeight);
    path.lineTo(arrowPosition - 10 + borderWidth, borderWidth);

    // 왼쪽 상단 모서리
    path.lineTo(borderWidth + 10, borderWidth);
    path.quadraticBezierTo(borderWidth, borderWidth, borderWidth, borderWidth + 4);
    path.lineTo(borderWidth, height - 4 - borderWidth);
    path.quadraticBezierTo(borderWidth, height - borderWidth, borderWidth + 4, height - borderWidth);

    // 아래, 오른쪽
    path.lineTo(width - 4 - borderWidth, height - borderWidth);
    path.quadraticBezierTo(width - borderWidth, height - borderWidth, width - borderWidth, height - 4 - borderWidth);
    path.lineTo(width - borderWidth, borderWidth + 4);
    path.quadraticBezierTo(width - borderWidth, borderWidth, width - 4 - borderWidth, borderWidth);

    path.lineTo(arrowPosition + borderWidth + 10, borderWidth);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }
}
