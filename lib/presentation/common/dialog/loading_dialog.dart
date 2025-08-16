import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }

  static void show() {
    Get.dialog(
      barrierDismissible: false,
      LoadingDialog(),
    );
  }
}
