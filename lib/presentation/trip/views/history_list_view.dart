import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/trip/controllers/history_list_controller.dart';
import 'package:tripStory/presentation/trip/widgets/history_image_tile.dart';
import 'package:tripStory/presentation/trip/widgets/history_item_header.dart';

class HistoryListView extends StatefulWidget {
  final DateTime dateTime;

  const HistoryListView({
    super.key,
    required this.dateTime,
  });

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final controller = Get.find<HistoryListController>();

  @override
  void initState() {
    super.initState();
    controller.init(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(),
      body: GetBuilder<HistoryListController>(
        builder: (HistoryListController controller) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Column(
              children: [
                HistoryItemHeader(
                  day: controller.state.day,
                  labelColor: context.color.blue,
                  photoDate: controller.state.historyEntity?.displayPhotoDate ?? "",
                  historyCount: controller.state.historyLength,
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.793,
                    ),
                    itemCount: controller.state.historyLength,
                    itemBuilder: (context, index) {
                      final history = controller.state.historyEntity?.historyList[index];

                      return HistoryImageTile(
                        thumbnail: history?.thumbnail ?? "",
                        userThumbnail: history?.profileImage ?? "",
                        likeCount: history?.likeCnt ?? 0,
                        replyCount: history?.replyCnt ?? 0,
                        onImagePressed: () => controller.onNavigateToDetailPressed(widget.dateTime),
                      );
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
