import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/color.dart';
import '../../util/font.dart';

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
            firstChild: Container(
              width:20,
              height: 20,
              decoration: BoxDecoration(
                  color: gray900,
                  borderRadius: BorderRadius.circular(2)
              ),
              child: SvgPicture.asset('assets/icon/smallCheck.svg',fit: BoxFit.none),
            ),
            secondChild: Container(
              width:20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffE0E0E0),width: 1.5),
                  borderRadius: BorderRadius.circular(2)
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: value == true? f15gray800w500 : f15gray800w500,
          ),
          Spacer(),
          GestureDetector(
              onTap: onPressed2,
              child: SvgPicture.asset(
                'assets/icon/arrow.svg',
                // color:  value == true  ? Colors.black : hintColor,
              ))
        ],
      ),
    );
  }
}
