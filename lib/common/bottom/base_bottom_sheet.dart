import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget child;
  final double heightRatio;
  final bool isScrollControlled;
  final EdgeInsets padding;

  const BaseBottomSheet({
    super.key,
    required this.child,
    this.heightRatio = 0.8,
    this.isScrollControlled = true,
    this.padding = const EdgeInsets.only(
      left: 20,
      right: 20,
      top: 10,
      bottom: 44,
    ),
  });

  static Future<T?> show<T>(
    BuildContext context,
    Widget child, {
    double heightRatio = 0.8,
    bool isScrollControlled = true,
    EdgeInsets padding = const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 44),
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => BaseBottomSheet(
        heightRatio: heightRatio,
        isScrollControlled: isScrollControlled,
        padding: padding,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        height: Get.height * heightRatio,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
