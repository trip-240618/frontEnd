import 'package:flutter/material.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/util/color.dart';

class IconTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final TextStyle textStyle;
  final Widget icon;

  const IconTextButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.textStyle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedBoxButton(
      onTap: onTap,
      icon: icon,
      text: text,
      textStyle: textStyle,
      backgroundColor: gray50,
      borderColor: gray200,
      borderRadius: 4,
      width: MediaQuery.of(context).size.width,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 16,
      ),
    );
  }
}
