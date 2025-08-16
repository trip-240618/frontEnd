import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_tile_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class LeadingIconTileButton extends StatelessWidget {
  final String? text;
  final String? placeholderText;
  final String leadingIconPath;
  final Color? iconColor;
  final VoidCallback onTilePressed;

  const LeadingIconTileButton({
    super.key,
    required this.text,
    this.placeholderText,
    required this.leadingIconPath,
    required this.iconColor,
    required this.onTilePressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = (text ?? "").isNotEmpty;

    return BaseTileButton(
      text: hasText ? text ?? "" : placeholderText ?? "",
      textStyle: context.style.body2Normal.copyWith(
        color: hasText ? context.color.gray800 : context.color.gray400,
        fontWeight: FontWeight.w500,
      ),
      onTap: onTilePressed,
      tileColor: context.color.gray50,
      borderColor: context.color.gray200,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      leading: SizedBox(
        width: 20,
        height: 20,
        child: SvgIcon(
          assetPath: leadingIconPath,
          color: iconColor,
        ),
      ),
    );
  }
}
