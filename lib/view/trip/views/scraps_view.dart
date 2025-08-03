import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/icon/svg_icon.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
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
          final status = controller.state.status;

          if (status == ScrapsStatus.initial) {
            return const SizedBox.shrink();
          }
          if (status == ScrapsStatus.empty) {
            return const EmptyScreen(
              content: "여행에 필요한 정보를\n스크랩 해보세요 :)",
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: MasonryGridView.count(
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemCount: controller.state.length,
                    itemBuilder: (context, index) {
                      final scrap = controller.state.scraps[index];
                      return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: scrap.color.toColor(),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  border:
                                      Border.all(color: context.color.gray200),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    SvgIcon(
                                      assetPath: 'assets/icon/bookmark.svg',
                                      color: scrap.bookmark
                                          ? context.color.gray900
                                          : null,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      scrap.createDate.formatYMDWithDot(),
                                      style: context.style.caption2.copyWith(
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
