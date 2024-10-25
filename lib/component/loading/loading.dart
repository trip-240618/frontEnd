import 'package:flutter/material.dart';
import '../../util/color.dart';

Widget LoadingList(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Center(
        child: CircularProgressIndicator(color: gray900,strokeWidth: 2,)
    ),
  );
}