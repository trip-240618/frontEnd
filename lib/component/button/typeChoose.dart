import 'package:flutter/material.dart';

import '../../util/color.dart';
import '../../util/font.dart';

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
            border: Border.all(color: value==text?gray900:gray200,width:value==text?2:1)
        ),
        child: Center(child: Text('${text}',style: value==text?f15gray900w600:f15gray300w600)),
      ),
    );
  }
}
