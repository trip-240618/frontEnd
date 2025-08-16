import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/font.dart';

class BottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool? isBlack;

  BottomContainer({Key? key, required this.onTap, required this.title, this.isBlack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 58,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: isBlack == true ? gray900 : gray300),
        child: Center(child: Text('${title}', style: isBlack == true ? f16Whitew700 : f16gray400w700)),
      ),
    );
  }
}

class BlackBottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  BlackBottomContainer({Key? key, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 58,
        decoration: BoxDecoration(color: gray900, borderRadius: BorderRadius.circular(4)),
        child: Center(
            child: Text(
          title,
          style: f16Whitew700,
        )),
      ),
    );
  }
}

class BlackCountContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final int count;

  BlackCountContainer({Key? key, required this.onTap, required this.title, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: Get.width,
          height: 58,
          decoration: BoxDecoration(color: gray900, borderRadius: BorderRadius.circular(4)),
          child: count == 0
              ? Center(child: Text(title, style: f16Whitew700))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: f16Whitew700,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          '${count}',
                          style: f12gray900w700,
                        )))
                  ],
                ),
        ),
      ),
    );
  }
}
