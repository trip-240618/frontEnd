import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/common/appbar/app_appbar.dart';
import 'package:tripStory/common/button/icon_button.dart';
import 'package:tripStory/common/button/popup_list.dart';
import 'package:tripStory/common/button/round_button.dart';
import 'package:tripStory/common/model/popup_item_model.dart';
import 'package:tripStory/common/snack_bar.dart';
import 'package:tripStory/common/widget/round_thumbnail_image.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/empty/emptyScreen.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/extension/date_extension.dart';
import 'package:tripStory/util/extension/string_extension.dart';
import 'package:tripStory/util/font.dart';
import 'package:tripStory/view/hoom/controller/rooms_controller.dart';
import 'package:tripStory/view/hoom/enum/trip_rooms_type.dart';

class TripRoomListView extends StatelessWidget {
  const TripRoomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (value, dynamic) {
            // TODO: 안드로이드 실기기에서 테스트 진행해야 함
            if (controller.shouldExitOnBackPressed()) {
              exit(0);
            }

            SnackBarHelper.show(
              context,
              '"뒤로" 버튼을 한 번 더 누르시면 종료됩니다',
            );
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: gray50,
            appBar: AppAppbar(
              isLeadingIcon: false,
              actionWidget: Row(
                children: [
                  AppIconButton(
                    onTap: () => controller.onNotificationPressed(),
                    assetPath: controller.notificationCount == 0 ? IconConstants.alert : IconConstants.alertOn,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  AppIconButton(
                    onTap: () => controller.onMyPagePressed(),
                    assetPath: IconConstants.person,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 44,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      RoundedBoxButton(
                        backgroundColor:
                            controller.tripRoomsState.tripRoomType == TripRoomType.coming ? gray900 : gray200,
                        onTap: () => controller.onComingTripPressed(),
                        text: "다가오는 여행",
                        textStyle: controller.tripRoomsState.tripRoomType == TripRoomType.coming
                            ? f14Whitew700
                            : f14gray400w700,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RoundedBoxButton(
                        backgroundColor:
                            controller.tripRoomsState.tripRoomType == TripRoomType.lastTrip ? gray900 : gray200,
                        onTap: () => controller.onLastTripPressed(),
                        text: "지난 여행",
                        textStyle: controller.tripRoomsState.tripRoomType == TripRoomType.lastTrip
                            ? f14Whitew700
                            : f14gray400w700,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RoundedBoxButton(
                        backgroundColor:
                            controller.tripRoomsState.tripRoomType == TripRoomType.bookmarked ? gray900 : gray200,
                        onTap: () => controller.onBookMarkTripPressed(),
                        text: "북마크",
                        textStyle: controller.tripRoomsState.tripRoomType == TripRoomType.bookmarked
                            ? f14Whitew700
                            : f14gray400w700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: controller.tripRoomsState.isTripRoomEmpty
                        ? EmptyScreen(
                            content: "새 여행 일정을\n 트립스토리에 등록해 보세요",
                          )
                        : SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: controller.tripRoomsState.tripListLength,
                              itemBuilder: (contexts, index) {
                                final tripRoom = controller.tripRoomsState.tripRooms[index];
                                return Column(
                                  children: [
                                    _TripRoomTile(
                                      tripRoom: tripRoom,
                                      tripRoomType: controller.tripRoomsState.tripRoomType,
                                      onTap: () => controller.onRoomPressed(),
                                      onBookmarkTap: () => controller.onBookmarkIconPressed(tripRoom.id),
                                      onSendTap: () => sendBottomModal(
                                        context,
                                        tripRoom.invitationCode,
                                        tripRoom.id,
                                      ),
                                      onMemberTap: (context) => _showMemberPopover(
                                        context: context,
                                        members: controller.getPopupMembers(tripRoom),
                                        width: 14 * controller.getLongestNicknameLength(tripRoom) + 100,
                                        height: 50 * tripRoom.memberCount.toDouble(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _TripBottomNavigation(
                    onInvitePressed: () => InviteDialog(context, () {
                      Get.back();
                    }),
                    onCreatePressed: () => controller.onRoomCreatedPressed(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showMemberPopover({
    required BuildContext context,
    required List<PopupItemModel> members,
    required double width,
    required double height,
  }) {
    showPopover(
      context: context,
      bodyBuilder: (context) => Material(
        child: PopupList(
          members: members,
        ),
      ),
      direction: PopoverDirection.bottom,
      width: width,
      height: height,
      contentDyOffset: 10,
      arrowHeight: 8,
      arrowWidth: 13,
    );
  }
}

class _TripRoomTile extends StatelessWidget {
  final TripRoomType tripRoomType;
  final TripRoomEntity tripRoom;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onSendTap;
  final Function(BuildContext)? onMemberTap;

  const _TripRoomTile({
    required this.tripRoomType,
    required this.tripRoom,
    this.onTap,
    this.onBookmarkTap,
    this.onSendTap,
    this.onMemberTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = tripRoom.labelColor.toColor();
    final dateRange = "${tripRoom.startDate.formatYMDWithHyphen()} ~ ${tripRoom.endDate.formatYMDWithHyphen()}";

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/icon/ticket.svg",
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 16,
              top: 8,
              right: 16,
              child: _buildHeader(
                labelColor,
                dateRange,
              ),
            ),
            Positioned(
              left: 16,
              top: 58,
              right: 16,
              bottom: 14,
              child: _TripContent(
                tripRoom: tripRoom,
                labelColor: labelColor,
                onMemberTap: onMemberTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color labelColor, String dateRange) {
    late final Widget leading;
    Widget? trailing;

    switch (tripRoomType) {
      case TripRoomType.lastTrip:
        leading = SvgPicture.asset("assets/icon/calender.svg");
        trailing = _buildTrailingWidget();
        break;

      case TripRoomType.coming:
      case TripRoomType.bookmarked:
        leading = RoundedBoxButton(
          text: tripRoom.dDay < 1 ? "여행중" : "D-${tripRoom.dDay}",
          textStyle: changeColor(labelColor),
          borderColor: labelColor,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        );
        trailing = _buildTrailingWidget(
          prefixIcon: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onSendTap,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset("assets/icon/send.svg", color: gray900),
            ),
          ),
        );
        break;
    }

    return _TripHeader(
      leadingWidget: leading,
      dateRange: dateRange,
      trailingWidget: trailing,
    );
  }

  Widget _buildTrailingWidget({
    Widget? prefixIcon,
  }) {
    final children = <Widget>[];

    if (prefixIcon != null) children.add(prefixIcon);

    children.add(
      InkWell(
        onTap: onBookmarkTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: tripRoom.bookmark
              ? SvgPicture.asset("assets/icon/checkBookmark.svg")
              : SvgPicture.asset("assets/icon/bookmark.svg"),
        ),
      ),
    );

    return Row(children: children);
  }
}

class _TripHeader extends StatelessWidget {
  final Widget leadingWidget;
  final String dateRange;
  final Widget? trailingWidget;

  const _TripHeader({
    required this.leadingWidget,
    required this.dateRange,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingWidget,
        const SizedBox(width: 6),
        Text(dateRange, style: f12Gray800w500),
        const Spacer(),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}

class _TripContent extends StatelessWidget {
  final TripRoomEntity tripRoom;
  final Color labelColor;
  final void Function(BuildContext)? onMemberTap;

  const _TripContent({
    required this.tripRoom,
    required this.labelColor,
    this.onMemberTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundThumbnailImage(
          imageUrl: tripRoom.thumbnail,
        ),
        const SizedBox(width: 12),
        _buildTripInfo(),
        const Spacer(),
        _buildMemberButton(),
      ],
    );
  }

  Widget _buildTripInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: labelColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  tripRoom.type.toUpperCase(),
                  style: f12Whitew700,
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              tripRoom.name,
              style: f15gray800w600,
            ),
          ],
        ),
        const Spacer(),
        Text(tripRoom.country, style: f12gray600w600),
      ],
    );
  }

  Widget _buildMemberButton() {
    return Builder(
      builder: (context) => RoundedBoxButton(
        onTap: () => onMemberTap?.call(context),
        text: tripRoom.memberCount.toString(),
        textStyle: f14gray600w700,
        backgroundColor: gray200,
        icon: SvgPicture.asset("assets/icon/userIcon.svg"),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      ),
    );
  }
}

class _TripBottomNavigation extends StatelessWidget {
  final VoidCallback onInvitePressed;
  final VoidCallback onCreatePressed;

  const _TripBottomNavigation({
    required this.onInvitePressed,
    required this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          RoundedBoxButton(
            width: 60,
            height: 60,
            backgroundColor: gray700,
            borderRadius: 4,
            icon: SvgPicture.asset(
              "assets/icon/chain.svg",
              fit: BoxFit.none,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onCreatePressed,
              child: RoundedBoxButton(
                width: 60,
                height: 60,
                backgroundColor: gray900,
                borderRadius: 4,
                text: "새 여행방 생성",
                textStyle: f16Whitew700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
