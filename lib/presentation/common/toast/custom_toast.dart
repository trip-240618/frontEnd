import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class CustomToast {
  static void show({
    required BuildContext context,
    required String message,
    String? icon,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    final fToast = FToast()..init(context);

    fToast.showToast(
      child: _ToastContent(
        message: message,
        icon: icon,
      ),
      gravity: gravity,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child, offset) {
        return Positioned(
          top: gravity == ToastGravity.TOP ? 100 : null,
          bottom: gravity == ToastGravity.BOTTOM ? 100 : null,
          left: 20,
          right: 20,
          child: child,
        );
      },
    );
  }
}

class _ToastContent extends StatelessWidget {
  final String message;
  final String? icon;

  const _ToastContent({
    required this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: context.color.gray900.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.10), offset: Offset(0, 4), blurRadius: 9),
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.09), offset: Offset(0, 16), blurRadius: 16),
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), offset: Offset(0, 36), blurRadius: 21),
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.01), offset: Offset(0, 63), blurRadius: 25),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgIcon(
              assetPath: icon ?? IconConstants.memo,
              color: context.color.white,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              message,
              style: context.style.label1Reading.copyWith(
                color: context.color.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
