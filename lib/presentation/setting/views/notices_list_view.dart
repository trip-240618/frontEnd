import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/font.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/button/tab/tab_box.dart';
import 'package:tripStory/presentation/common/divider/common_divider.dart';
import 'package:tripStory/presentation/setting/controllers/notices_list_controller.dart';
import 'package:tripStory/presentation/setting/models/notices_list_state.dart';

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
                    TabBox(
                      label: "전체",
                      onPressed: () => controller.onNoticesTypePressed(NoticesType.all),
                      selected: controller.state.selectedNoticesType == NoticesType.all,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TabBox(
                      label: "일반",
                      onPressed: () => controller.onNoticesTypePressed(NoticesType.normal),
                      selected: controller.state.selectedNoticesType == NoticesType.normal,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TabBox(
                      label: "업데이트",
                      onPressed: () => controller.onNoticesTypePressed(NoticesType.update),
                      selected: controller.state.selectedNoticesType == NoticesType.update,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TabBox(
                      label: "시스템",
                      onPressed: () => controller.onNoticesTypePressed(NoticesType.system),
                      selected: controller.state.selectedNoticesType == NoticesType.system,
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
