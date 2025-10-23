import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_manager/photo_manager.dart' as photo;
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/bottomSheetHeader.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/presentation/common/button/base/base_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/dialog/common_dialog.dart';
import 'package:tripStory/presentation/common/dialog/day_select_dialog.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/trip/controllers/history_main_controller.dart';
import 'package:tripStory/presentation/trip/models/history_main_state.dart';
import 'package:tripStory/presentation/trip/widgets/history_image_tile.dart';
import 'package:tripStory/presentation/trip/widgets/history_item_header.dart';

class HistoryMainView extends StatefulWidget {
  const HistoryMainView({
    super.key,
  });

  @override
  State<HistoryMainView> createState() => _HistoryMainViewState();
}

class _HistoryMainViewState extends State<HistoryMainView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryMainController>(
      builder: (controller) {
        final state = controller.state;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final showPermissionDialog = state.showPhotoPermissionDialog?.consume();
          final showDayDialog = state.showDaySelectedDialog?.consume();
          if (showPermissionDialog != null) {
            _showPhotoPermissionDialog();
          }

          if (showDayDialog != null) {
            _showDaySelectDialog(
              controller.tripRoomInfo?.startDate,
              controller.tripRoomInfo?.endDate,
              controller.onSelectedDayPressed,
              controller.onSelectedDayDialogConfirmPressed,
            );
          }
        });
        return Stack(
          children: [
            Visibility(
              visible: state.historyStatus == HistoryStatus.success,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.currentLatitude,
                    state.currentLongitude,
                  ),
                  zoom: 14.4746,
                ),
                markers: state.markers.toSet(),
                // onCameraMove: maps.manager.onCameraMove,
                // onCameraIdle: maps.manager.updateMap,
                onMapCreated: (GoogleMapController mapController) {
                  if (!controller.mapController.isCompleted) {
                    controller.mapController.complete(mapController);
                    controller.manager?.setMapId(mapController.mapId);
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: context.color.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  minChildSize: 0.1,
                  maxChildSize: 0.75,
                  expand: false,
                  shouldCloseOnMinExtent: false,
                  snap: true,
                  controller: controller.scrollableController,
                  snapSizes: [0.1, 0.4, 0.75],
                  builder: (context, scrollController) {
                    return CustomScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        _BottomSheetHeader(
                          tripRoomName: controller.tripRoomInfo?.name ?? "",
                          onHomePressed: () => {},
                          onPhotoPressed: () => controller.onPhotoPressed(),
                        ),
                        _BottomSheetContent(
                          labelColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.blue,
                          histories: state.histories,
                          onHeaderPressed: (index) => controller.onHistoryItemHeaderPressed(index),
                          onImagePressed: (index) => controller.onImagePressed(index),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: _HistorySearchBar(
                onSearchBarPressed: () {},
                searchBarColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPhotoPermissionDialog() {
    CommonDialog.showConfirm(
      title: "권한을 설정해주시기 바랍니다",
      onConfirm: () {
        photo.PhotoManager.openSetting();
        Get.back();
      },
    );
  }

  void _showDaySelectDialog(
    DateTime? startDate,
    DateTime? endDate,
    final void Function(DateTime selectedDate) onChanged,
    final VoidCallback onConfirmPressed,
  ) {
    if (startDate == null || endDate == null) {
      return;
    }

    DaySelectDialog.show(
      title: "날짜 선택",
      startDate: startDate,
      endDate: endDate,
      onChanged: onChanged,
      onConfirmPressed: onConfirmPressed,
    );
  }
}

class _HistorySearchBar extends StatelessWidget {
  final VoidCallback onSearchBarPressed;
  final Color searchBarColor;

  const _HistorySearchBar({
    required this.onSearchBarPressed,
    required this.searchBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: context.color.gray50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: context.color.gray200),
        boxShadow: [
          BoxShadow(
            color: context.color.charcoal.withValues(alpha: 0.1),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: context.color.charcoal.withValues(alpha: 0.09),
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
          BoxShadow(
            color: context.color.charcoal.withValues(alpha: 0.05),
            offset: Offset(0, 7),
            blurRadius: 4,
          ),
          BoxShadow(
            color: context.color.charcoal.withValues(alpha: 0.01),
            offset: Offset(0, 13),
            blurRadius: 5,
          ),
        ],
      ),
      child: BaseButton(
        onTap: onSearchBarPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              SvgIcon(
                assetPath: IconConstants.smallSearch,
                color: searchBarColor,
              ),
              const SizedBox(width: 8),
              Text(
                "태그, 닉네임으로 사진을 검색해보세요",
                style: context.style.body2Normal.copyWith(
                  color: context.color.gray400,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetHeader extends StatelessWidget {
  final String tripRoomName;
  final VoidCallback onHomePressed;
  final VoidCallback onPhotoPressed;

  const _BottomSheetHeader({
    required this.tripRoomName,
    required this.onHomePressed,
    required this.onPhotoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      key: ValueKey(tripRoomName),
      floating: false,
      delegate: CustomSliverPersistentHeaderDelegate(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 10,
            ),
            child: Column(
              children: [
                Container(
                  width: 54,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.color.gray400,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIconButton(
                      assetPath: IconConstants.home,
                      onTap: onHomePressed,
                    ),
                    Text(
                      tripRoomName,
                      style: context.style.headline3,
                    ),
                    AppIconButton(
                      assetPath: IconConstants.roundPlus,
                      onTap: onPhotoPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  final List<HistoriesEntity> histories;
  final Color labelColor;
  final Function(int) onHeaderPressed;
  final Function(int) onImagePressed;

  const _BottomSheetContent({
    required this.labelColor,
    required this.histories,
    required this.onHeaderPressed,
    required this.onImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: histories.length,
          (context, listIndex) {
            final history = histories[listIndex].historyList;
            final photoDate = histories[listIndex].displayPhotoDate;

            return Column(
              children: [
                Container(
                  width: Get.width,
                  height: history.isEmpty ? 60 : 222,
                  decoration: BoxDecoration(
                    color: context.color.white,
                    border: Border(
                      top: BorderSide(color: context.color.gray200, width: 0.5),
                      bottom: BorderSide(color: context.color.gray200, width: 0.5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 16,
                      bottom: history.isEmpty ? 0 : 16,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: HistoryItemHeader(
                            day: listIndex + 1,
                            labelColor: labelColor,
                            photoDate: photoDate,
                            historyCount: history.length,
                            onHeaderPressed: history.isEmpty ? null : () => onHeaderPressed(listIndex),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: history.length,
                            scrollDirection: Axis.horizontal,
                            addRepaintBoundaries: false,
                            addAutomaticKeepAlives: false,
                            itemBuilder: (context, index) {
                              final historyEntity = history[index];
                              return HistoryImageTile(
                                thumbnail: historyEntity.thumbnail,
                                userThumbnail: historyEntity.profileImage ?? "",
                                likeCount: historyEntity.likeCnt ?? 0,
                                replyCount: historyEntity.replyCnt ?? 0,
                                onImagePressed: () => onImagePressed(listIndex),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(width: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
