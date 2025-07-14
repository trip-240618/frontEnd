import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/divider/common_divider.dart';
import 'package:tripStory/util/extension/context_extension.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/setting/controllers/notices_list_controller.dart';
import 'package:tripStory/view/setting/models/notices_list_state.dart';

class NoticesListView extends StatefulWidget {
  const NoticesListView({
    super.key,
  });

  @override
  State<NoticesListView> createState() => _NoticesListViewState();
}

class _NoticesListViewState extends State<NoticesListView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticesListController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppAppbar(
            text: "공지사항",
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 13),
                Row(
                  children: [
                    RoundedBoxButton(
                      backgroundColor: controller.state.selectedNoticesType == NoticesType.all
                          ? context.color.gray900
                          : context.color.gray200,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      onTap: () => controller.onNoticesTypePressed(NoticesType.all),
                      text: "전체",
                      textStyle: controller.state.selectedNoticesType == NoticesType.all
                          ? context.style.label1Normal.copyWith(
                              color: context.color.white,
                            )
                          : context.style.label1Normal.copyWith(
                              color: context.color.gray400,
                            ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    RoundedBoxButton(
                      backgroundColor: controller.state.selectedNoticesType == NoticesType.normal
                          ? context.color.gray900
                          : context.color.gray200,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      onTap: () => controller.onNoticesTypePressed(NoticesType.normal),
                      text: "일반",
                      textStyle: controller.state.selectedNoticesType == NoticesType.normal
                          ? context.style.label1Normal.copyWith(
                              color: context.color.white,
                            )
                          : context.style.label1Normal.copyWith(
                              color: context.color.gray400,
                            ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    RoundedBoxButton(
                      backgroundColor: controller.state.selectedNoticesType == NoticesType.update
                          ? context.color.gray900
                          : context.color.gray200,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      onTap: () => controller.onNoticesTypePressed(NoticesType.update),
                      text: "업데이트",
                      textStyle: controller.state.selectedNoticesType == NoticesType.update
                          ? context.style.label1Normal.copyWith(
                              color: context.color.white,
                            )
                          : context.style.label1Normal.copyWith(
                              color: context.color.gray400,
                            ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    RoundedBoxButton(
                      backgroundColor: controller.state.selectedNoticesType == NoticesType.system
                          ? context.color.gray900
                          : context.color.gray200,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      onTap: () => controller.onNoticesTypePressed(NoticesType.system),
                      text: "시스템",
                      textStyle: controller.state.selectedNoticesType == NoticesType.system
                          ? context.style.label1Normal.copyWith(
                              color: context.color.white,
                            )
                          : context.style.label1Normal.copyWith(
                              color: context.color.gray400,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: controller.state.noticesLength,
                      padding: EdgeInsets.zero,
                      itemBuilder: (contexts, index) {
                        final notice = controller.state.notices[index];

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            // notiS.notiDetailList.clear();
                            // await notiS.getDetailNoti(notiS.notiList[index]['id'], notiS.notiList[index]['type']);
                            // Get.to(() => SettingNotiDetail());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "[${notice.type}] ${notice.title}",
                                style: context.style.body2Normal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${notice.createDate}",
                                style: f12gray400w500,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CommonDivider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
