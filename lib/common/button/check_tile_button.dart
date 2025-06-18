import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripStory/common/button/base/base_tile_button.dart';
import 'package:tripStory/util/font.dart';

class CheckTileButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final Color? tileColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;

  const CheckTileButton({
    super.key,
    required this.text,
    required this.isActive,
    this.tileColor,
    this.onTap,
    this.onTrailingTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTileButton(
      text: text,
      textStyle: isActive ? f15gray900w600 : f15gray800w500,
      onTap: onTap,
      tileColor: tileColor,
      borderColor: borderColor,
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF212121) : Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: isActive ? SvgPicture.asset("assets/icon/smallCheck.svg", fit: BoxFit.none) : null,
      ),
      trailing: GestureDetector(
        onTap: onTrailingTap,
        child: SvgPicture.asset("assets/icon/arrow.svg"),
      ),
    );
  }
}
