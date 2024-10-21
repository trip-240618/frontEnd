import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlusFloatingButton extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onPressed;

  const PlusFloatingButton({Key? key,
    required this.backgroundColor,
    required this.onPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: SvgPicture.asset('assets/icon/plus2.svg'),
        shape: CircleBorder(),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
    );
  }
}