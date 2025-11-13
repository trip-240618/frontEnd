import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/empty_view.dart';
import 'package:tripStory/presentation/common/tag/tag.dart';
import 'package:tripStory/presentation/trip/controllers/history_search_list_controller.dart';
import 'package:tripStory/presentation/trip/models/history_search_list_state.dart';
import 'package:tripStory/presentation/trip/models/history_search_param.dart';
import 'package:tripStory/presentation/trip/widgets/history_image_grid.dart';

class HistorySearchListView extends StatefulWidget {
  final HistorySearchParam param;

  const HistorySearchListView({
    super.key,
    required this.param,
  });

  @override
  State<HistorySearchListView> createState() => _HistorySearchListViewState();
}

class _HistorySearchListViewState extends State<HistorySearchListView> {
  final controller = Get.find<HistorySearchListController>();

  @override
  void initState() {
    super.initState();
    controller.init(widget.param);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        text: "사진 검색",
      ),
      body: GetBuilder<HistorySearchListController>(
        builder: (HistorySearchListController controller) {
          final state = controller.state;
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                switch (widget.param) {
                  TagSearchParam(tag: final tag) => Tag.hashtag(
                      label: tag.tagName,
                      leadingColor: tag.tagColor.toColor(),
                    ),
                  MemberSearchParam(member: final member) => Tag.person(
                      label: member.nickname,
                      imageUrl: member.thumbnail,
                    ),
                },
                const SizedBox(
                  height: 16,
                ),
                if (state.historySearchListStatus == HistorySearchListStatus.empty)
                  Expanded(
                    child: const EmptyView(content: "해당 검색 결과가 없습니다\n다른 키워드로 검색해보세요"),
                  ),
                Expanded(
                  child: HistoryImageGrid(
                    onImagePressed: () => controller.onNavigateToHistoryDetail(),
                    histories: state.histories ?? [],
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
