import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/enum/history_search_type.dart';
import 'package:tripStory/core/enum/text_edit_type.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/button/tab/tab_box.dart';
import 'package:tripStory/presentation/common/empty_view.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/tag/tag.dart';
import 'package:tripStory/presentation/common/text/edit/edit_text_form_field.dart';
import 'package:tripStory/presentation/trip/controllers/history_search_controller.dart';

class HistorySearchView extends StatelessWidget {
  const HistorySearchView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        text: "사진 검색",
      ),
      body: GetBuilder<HistorySearchController>(
        builder: (controller) {
          final state = controller.state;
          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditTextFormField(
                  controller: controller.textCon,
                  leadingWidget: state.searchMode
                      ? null
                      : SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgIcon(
                            assetPath: IconConstants.search,
                          ),
                        ),
                  hintText: "태그,닉네임으로 사진을 검색해보세요",
                  editType: TextEditType.cancel,
                  backgroundColor: context.color.gray50,
                  onTrailingPressed: () => controller.onSearchModeCancelPressed(),
                  onSubmit: (text) => controller.onSearchPressed(),
                  isTrailing: state.searchMode,
                ),
                if (!state.searchMode) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      TabBox(
                        label: "사진 태그",
                        onPressed: () => controller.onTypePressed(HistorySearchType.tag),
                        selected: HistorySearchType.tag == state.historySearchType,
                      ),
                      const SizedBox(width: 8),
                      TabBox(
                        label: "닉네임",
                        onPressed: () => controller.onTypePressed(HistorySearchType.nickName),
                        selected: HistorySearchType.nickName == state.historySearchType,
                      ),
                    ],
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
                if (state.isSearchEmpty)
                  Center(
                    child: EmptyView(
                      content: "해당 검색 결과가 없습니다\n다른 키워드로 검색 해보세요",
                      fontStyle: context.style.heading2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.color.gray400,
                      ),
                    ),
                  ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ...state.members.where((_) {
                      if (state.searchMode) return true;
                      return state.historySearchType == HistorySearchType.nickName;
                    }).map(
                      (member) => Tag.person(
                        label: member.nickname,
                        imageUrl: member.thumbnail,
                        onTap: () => controller.onNavigateToMemberSearchPressed(member),
                      ),
                    ),
                    ...state.tags.where((_) {
                      if (state.searchMode) return true;
                      return state.historySearchType == HistorySearchType.tag;
                    }).map(
                      (tag) => Tag.hashtag(
                        label: tag.tagName,
                        leadingColor: tag.tagColor.toColor(),
                        onTap: () => controller.onNavigateToTagSearchPressed(tag),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
