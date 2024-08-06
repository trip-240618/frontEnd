import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/font.dart';

class SettingArrowRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingArrowRow({
    required this.title,
    required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(title, style: f16darkGray1w400),
          Spacer(),
          SizedBox(
            child: SvgPicture.asset(
              'assets/icon/rightArrow.svg',
              fit: BoxFit.none,
            ),
          ),
        ],
      ),
    );
  }
}