import 'package:flutter/material.dart';

import '../../util/color.dart';

class TypeChoose extends StatelessWidget {
  final String text;
  final String? value;
  final VoidCallback onTap;
  TypeChoose({super.key, required this.text, required this.onTap, this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: value==text?mainRed:gray200)
        ),
        child: Center(child: Text('${text}')),
      ),
    );
  }
}
