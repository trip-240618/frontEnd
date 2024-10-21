import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../util/color.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingAnimationWidget.waveDots(
        color: gray900,
        size: 50,
      ),
    );
  }
}

showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    builder: (ctx) {
      return Center(child: LoadingAnimationWidget.hexagonDots(
        color: Colors.white,
        size: 50,
      ));
    },
    context: context,
  );
}
