import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/view/trip/controllers/scraps_controller.dart';
import 'package:tripStory/view/trip/models/scraps_state.dart';

class ScrapsView extends StatelessWidget {
  const ScrapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.gray50,
      body: GetBuilder<ScrapsController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: controller.state.status == ScrapsStatus.empty
                          ? 1
                          : controller.state.length,
                      itemBuilder: (contexts, index) {
                        final status = controller.state.status;

                        if (status == ScrapsStatus.initial) {
                          return const SizedBox.shrink();
                        }

                        if (status == ScrapsStatus.empty) {
                          return const EmptyScreen(
                            content: "여행에 필요한 정보를\n스크랩 해보세요 :)",
                          );
                        }
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
