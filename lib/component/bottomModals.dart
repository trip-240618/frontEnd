import 'package:flutter/material.dart';
import 'package:get/get.dart';


void bottomModel(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Container(
              color: Colors.red,
              height: Get.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image.asset('assets/icon/underbar.png')),

                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          },
        );
      });
}