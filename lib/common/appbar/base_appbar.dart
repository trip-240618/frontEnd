import 'package:flutter/material.dart';
import 'package:tripStory/util/color.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? actionWidget;

  const BaseAppbar({
    super.key,
    this.color = gray50,
    this.leadingWidget,
    this.titleWidget,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 44,
      titleSpacing: 0,
      actionsPadding: const EdgeInsets.only(
        right: 16,
      ),
      leading: leadingWidget,
      title: titleWidget,
      actions: [
        if (actionWidget != null) actionWidget!,
      ],
      backgroundColor: color,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
