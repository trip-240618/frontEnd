import 'package:flutter/material.dart';
import 'package:tripStory/common/button/base/base_tile_button.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/util/extension/context_extension.dart';

class DeletedTileButton extends StatelessWidget {
  final String? text;
  final String placeholderText;
  final Color? iconColor;
  final VoidCallback onTilePressed;
  final VoidCallback onDeletePressed;

  const DeletedTileButton({
    super.key,
    required this.text,
    required this.placeholderText,
    required this.iconColor,
    required this.onTilePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasText = text != null && text!.isNotEmpty;

    return BaseTileButton(
      text: text != null ? text! : placeholderText,
      textStyle: context.style.body2Normal.copyWith(
        color: hasText ? context.color.gray800 : context.color.gray400,
      ),
      onTap: hasText ? null : onTilePressed,
      tileColor: context.color.gray50,
      borderColor: context.color.gray200,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      leading: hasText
          ? null
          : SizedBox(
              width: 20,
              height: 20,
              child: SvgIcon(
                assetPath: IconConstants.search,
                color: iconColor,
              ),
            ),
      trailing: hasText
          ? GestureDetector(
              onTap: onDeletePressed,
              child: SizedBox(
                width: 20,
                height: 20,
                child: SvgIcon(
                  assetPath: IconConstants.clear,
                  color: context.color.gray900,
                ),
              ),
            )
          : null,
    );
  }
}
