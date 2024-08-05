import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 약관 폼
class termsForm extends StatelessWidget {
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;
  final bool value;
  final String text;

  const termsForm({Key? key, required this.text, this.onPressed1, this.onPressed2, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed1,
      child: Row(
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: value == true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: SvgPicture.asset(
              'assets/icon/check.svg',
              width: 20,
              height: 20,
            ),
            secondChild: SvgPicture.asset(
              'assets/icon/notcheck.svg',
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            text,
            // style:  value == true? f14bw700 : f14w600,
          ),
          Spacer(),
          GestureDetector(
              onTap: onPressed2,
              child: SvgPicture.asset(
                'assets/icon/arrow.svg',
                width: 14,
                height: 14,
                // color:  value == true  ? Colors.black : hintColor,
              ))
        ],
      ),
    );
  }
}