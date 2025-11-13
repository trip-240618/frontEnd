import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/text_edit_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/helper/text_span_helper.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/button/box/box_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/text/input/input_text_form_field.dart';

class EditTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextEditType editType;
  final VoidCallback? onTrailingPressed;
  final String? countText;
  final String? buttonText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final ValueChanged<String>? onSubmit;
  final FocusNode? focusNode;
  final bool? isFocusOnTapOutside;
  final double? maxHeight;
  final int? maxLines;
  final Widget? leadingWidget;
  final bool? isTrailing;
  final Color? backgroundColor;

  const EditTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.editType = TextEditType.cancel,
    this.onTrailingPressed,
    this.countText,
    this.buttonText,
    this.inputFormatters,
    this.onChanged,
    this.onSubmit,
    this.focusNode,
    this.isFocusOnTapOutside,
    this.maxHeight,
    this.maxLines,
    this.leadingWidget,
    this.isTrailing = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InputTextField(
      controller: controller,
      isFocusOnTapOutside: isFocusOnTapOutside,
      hintText: hintText,
      maxLines: maxLines ?? 1,
      minLines: 1,
      onChanged: onChanged,
      focusNode: focusNode,
      maxHeight: maxHeight,
      inputFormatters: inputFormatters,
      onFieldSubmitted: onSubmit,
      leading: leadingWidget,
      backgroundColor: backgroundColor,
      trailing: isTrailing ?? true
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (countText != null && countText!.isNotEmpty) ...[
                  Text.rich(
                    TextSpanHelper.toSplitText(
                      text: countText ?? "",
                      delimiter: "/",
                      firstStyle: context.style.caption2.copyWith(color: context.color.gray800),
                      secondStyle: context.style.caption2.copyWith(color: context.color.gray400),
                      delimiterStyle: context.style.caption2.copyWith(
                        color: context.color.gray400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                _TrailingWidget(
                  editType: editType,
                  onTrailingPressed: onTrailingPressed,
                  buttonText: buttonText,
                ),
              ],
            )
          : null,
    );
  }
}

class _TrailingWidget extends StatelessWidget {
  final TextEditType editType;
  final VoidCallback? onTrailingPressed;
  final String? buttonText;

  const _TrailingWidget({
    required this.editType,
    this.onTrailingPressed,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    switch (editType) {
      case TextEditType.button:
        return BoxButton(
          label: buttonText ?? "",
          onPressed: onTrailingPressed ?? () {},
        );

      case TextEditType.cancel:
        return _IconTrailing(
          assetPath: IconConstants.smallClear,
          onTap: onTrailingPressed,
        );

      case TextEditType.next:
        return _IconTrailing(
          assetPath: IconConstants.smallSubtract,
          onTap: onTrailingPressed,
        );

      case TextEditType.edit:
        return _IconTrailing(
          assetPath: IconConstants.smallNameEdit,
          onTap: onTrailingPressed,
        );
    }
  }
}

class _IconTrailing extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const _IconTrailing({
    required this.assetPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: BaseButton(
        onTap: onTap,
        borderRadius: 100,
        child: Center(
          child: SvgIcon(
            assetPath: assetPath,
          ),
        ),
      ),
    );
  }
}
