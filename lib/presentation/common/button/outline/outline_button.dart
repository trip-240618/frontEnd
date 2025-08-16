import 'package:flutter/material.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';

enum OutlineState { pressed, defaults, disabled }

class OutlineButton extends StatelessWidget {
  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback? onPressed;

  const OutlineButton({
    super.key,
    required this.label,
    this.selected = false,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final state = _resolveState(selected, disabled);
    final style = _buttonStyles(context, state);

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: style.borderColor, width: style.borderWidth),
      ),
      child: BaseButton(
        onTap: disabled ? null : onPressed,
        child: Center(
          child: Text(
            label,
            style: context.style.body2Normal.copyWith(
              color: style.fontColor,
            ),
          ),
        ),
      ),
    );
  }

  OutlineState _resolveState(bool selected, bool disabled) {
    if (disabled) return OutlineState.disabled;
    if (selected) return OutlineState.pressed;
    return OutlineState.defaults;
  }

  ({
    Color backgroundColor,
    Color fontColor,
    Color borderColor,
    double borderWidth,
  }) _buttonStyles(BuildContext context, OutlineState state) {
    switch (state) {
      case OutlineState.disabled:
        return (
          backgroundColor: context.color.gray50,
          fontColor: context.color.gray300,
          borderColor: context.color.gray200,
          borderWidth: 1.0,
        );
      case OutlineState.defaults:
        return (
          backgroundColor: context.color.white,
          fontColor: context.color.gray600,
          borderColor: context.color.gray200,
          borderWidth: 1.0,
        );
      case OutlineState.pressed:
        return (
          backgroundColor: context.color.gray50,
          fontColor: context.color.gray900,
          borderColor: context.color.gray900,
          borderWidth: 2,
        );
    }
  }
}
