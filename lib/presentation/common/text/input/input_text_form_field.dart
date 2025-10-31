import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/helper/text_span_helper.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/text/base_text_form_field.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onFieldSubmitted;

  /// leading
  final Widget? leading;
  final String? leadingIconPath;
  final Color? leadingIconColor;
  final VoidCallback? onLeadingPressed;

  /// trailing
  final Widget? trailing;
  final int? maxCountText;

  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Color? borderColor;
  final EdgeInsets? scrollPadding;
  final int? maxLines;
  final int? minLines;
  final bool? isFocusOnTapOutside;
  final TextInputType? keyboardType;
  final double? maxHeight;

  const InputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.leading,
    this.trailing,
    this.textStyle,
    this.contentPadding,
    this.backgroundColor,
    this.focusNode,
    this.borderColor,
    this.onFieldSubmitted,
    this.scrollPadding,
    this.maxLines,
    this.isFocusOnTapOutside,
    this.keyboardType,
    this.minLines,
    this.maxHeight,
    this.maxCountText,
    this.leadingIconPath,
    this.leadingIconColor,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    final text = controller.text;
    final currentCount = text.length;

    Widget? leadingWidget;
    if (leading != null) {
      leadingWidget = leading;
    } else if (leadingIconPath != null) {
      leadingWidget = GestureDetector(
        onTap: onLeadingPressed,
        child: SizedBox(
          width: 20,
          height: 20,
          child: SvgIcon(
            assetPath: leadingIconPath!,
            color: leadingIconColor ?? context.color.gray700,
          ),
        ),
      );
    }

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.color.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor ?? context.color.gray200),
      ),
      child: Row(
        children: [
          if (leadingWidget != null) ...[
            const SizedBox(width: 16),
            leadingWidget,
          ],
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? double.infinity,
              ),
              child: BaseTextFormField(
                controller: controller,
                focusNode: focusNode,
                hintText: hintText,
                onChanged: onChanged,
                inputFormatters: inputFormatters,
                textStyle: textStyle,
                contentPadding: contentPadding,
                onFieldSubmitted: onFieldSubmitted,
                scrollPadding: scrollPadding,
                maxLines: maxLines,
                minLines: minLines,
                isFocusOnTapOutside: isFocusOnTapOutside,
                keyboardType: keyboardType,
              ),
            ),
          ),
          if (maxCountText != null || trailing != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: maxCountText != null
                  ? Text.rich(
                      TextSpanHelper.toSplitText(
                        text: "$currentCount/$maxCountText",
                        delimiter: "/",
                        firstStyle: context.style.caption2.copyWith(
                          color: currentCount == 0 ? context.color.gray400 : context.color.gray800,
                        ),
                        secondStyle: context.style.caption2.copyWith(
                          color: context.color.gray400,
                        ),
                        delimiterStyle: context.style.caption2.copyWith(
                          color: context.color.gray400,
                        ),
                      ),
                    )
                  : trailing!,
            ),
          ],
        ],
      ),
    );
  }
}
