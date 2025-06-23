import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/base_appbar.dart';
import 'package:tripStory/common/button/icon_button.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final String? icon;
  final bool? isLeadingIcon;
  final VoidCallback? onTap;
  final Widget? leadingWidget;
  final Widget? actionWidget;

  const AppAppbar({
    super.key,
    this.text,
    this.icon,
    this.isLeadingIcon = true,
    this.onTap,
    this.leadingWidget,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAppbar(
      leadingWidget: isLeadingIcon == true
          ? (leadingWidget ??
              AppIconButton(
                assetPath: icon ?? IconConstants.leftArrow,
                onTap: onTap ?? () => Get.back(),
              ))
          : null,
      titleWidget: Text(
        text ?? "",
        style: context.style.body1Normal,
      ),
      actionWidget: actionWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
