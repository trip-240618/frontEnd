import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget child;
  final double heightRatio;
  final bool isScrollControlled;

  const BaseBottomSheet({
    super.key,
    required this.child,
    this.heightRatio = 0.4,
    this.isScrollControlled = true,
  });

  static Future<T?> show<T>(
    BuildContext context,
    Widget child, {
    double heightRatio = 0.4,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      builder: (_) => BaseBottomSheet(
        heightRatio: heightRatio,
        isScrollControlled: isScrollControlled,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        color: context.color.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        child: SizedBox(
          width: double.infinity,
          height: Get.height * heightRatio,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 44,
            ),
            child: Column(
              children: [
                _BottomHeader(),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomHeader extends StatelessWidget {
  const _BottomHeader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: context.color.neutral300,
        ),
      ),
    );
  }
}
