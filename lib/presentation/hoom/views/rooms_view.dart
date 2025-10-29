import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/color.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/date_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/core/util/font.dart';
import 'package:tripStory/domain/entities/trip_room_entity.dart';
import 'package:tripStory/presentation/common/appbar/app_appbar.dart';
import 'package:tripStory/presentation/common/bottom/base_bottom_sheet.dart';
import 'package:tripStory/presentation/common/button/app_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/button/link_button.dart';
import 'package:tripStory/presentation/common/button/popup_list.dart';
import 'package:tripStory/presentation/common/button/tab/tab_box.dart';
import 'package:tripStory/presentation/common/button/tab/tab_user.dart';
import 'package:tripStory/presentation/common/button/tile/tile_list_button.dart';
import 'package:tripStory/presentation/common/dialog/code_insert_dialog.dart';
import 'package:tripStory/presentation/common/empty_view.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/image/round_thumbnail_image.dart';
import 'package:tripStory/presentation/common/popup/popup_item_model.dart';
import 'package:tripStory/presentation/common/snack_bar.dart';
import 'package:tripStory/presentation/common/tag/tag_day.dart';
import 'package:tripStory/presentation/common/toast/custom_toast.dart';
import 'package:tripStory/presentation/hoom/controller/rooms_controller.dart';
import 'package:tripStory/presentation/hoom/enum/trip_rooms_type.dart';
import 'package:tripStory/presentation/hoom/model/trip_rooms_state.dart';

class TripRoomListView extends StatelessWidget {
  const TripRoomListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(
      builder: (controller) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final name = controller.state.showToast?.consume();
          if (name != null && context.mounted) {
            showToast(context, name);
          }
        });

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
              backgroundColor: context.color.gray50,
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
                      TabBox(
                        label: "다가오는 여행",
                        onPressed: () => controller.onComingTripPressed(),
                        selected: controller.tripRoomsState.tripRoomType == TripRoomType.coming,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TabBox(
                        label: "지난 여행",
                        onPressed: () => controller.onLastTripPressed(),
                        selected: controller.tripRoomsState.tripRoomType == TripRoomType.lastTrip,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TabBox(
                        label: "북마크",
                        onPressed: () => controller.onBookMarkTripPressed(),
                        selected: controller.tripRoomsState.tripRoomType == TripRoomType.bookmarked,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: controller.tripRoomsState.isTripRoomEmpty
                        ? EmptyView(
                            content: "새 여행 일정을\n 트립스토리에 등록해 보세요",
                            fontStyle: context.style.heading1.copyWith(
                              color: context.color.gray400,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller.tripRoomsState.tripListLength,
                            itemBuilder: (contexts, index) {
                              final status = controller.tripRoomsState.tripRoomsStatus;

                              if (status == TripRoomsStatus.initial) {
                                return const SizedBox.shrink();
                              }
                              final tripRoom = controller.tripRoomsState.tripRooms[index];
                              return Column(
                                children: [
                                  _TripRoomTile(
                                    tripRoom: tripRoom,
                                    tripRoomType: controller.tripRoomsState.tripRoomType,
                                    onTap: () => controller.onRoomPressed(tripRoom.id),
                                    onBookmarkTap: () => controller.onBookmarkIconPressed(tripRoom.id, index),
                                    onSendTap: () => _showShareInviteModal(
                                      context,
                                      onCopyCodePressed: () =>
                                          controller.onInviteCodeCopyPressed(tripRoom.invitationCode),
                                      onKakaoSharePressed: () => controller.onKakaoSharePressed(
                                        tripRoom.tripId,
                                        tripRoom.invitationCode,
                                      ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  _TripBottomNavigation(
                    onInvitePressed: () => _showEnterCodeDialog(
                      context: context,
                      onConfirmPressed: (invitationCode) => controller.onJoinCodePressed(invitationCode),
                    ),
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

  void _showEnterCodeDialog({
    required BuildContext context,
    required Future<bool> Function(String inviteCode) onConfirmPressed,
  }) {
    CodeInsertDialog.show(
      context,
      onConfirmPressed,
    );
  }

  void _showShareInviteModal(
    BuildContext context, {
    required VoidCallback onKakaoSharePressed,
    required VoidCallback onCopyCodePressed,
  }) {
    BaseBottomSheet.show(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "초대 코드를 복사했어요",
              style: context.style.heading1.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TileListButton(
            text: "카카오톡으로 공유하기",
            leading: SvgIcon(assetPath: IconConstants.kakaoIcon),
            textStyle: context.style.body1Normal.copyWith(
              fontWeight: FontWeight.w500,
            ),
            showTrailing: false,
            onTap: onKakaoSharePressed,
          ),
          TileListButton(
            text: "초대 코드 복사하기",
            textStyle: context.style.body1Normal.copyWith(
              fontWeight: FontWeight.w500,
            ),
            leading: SvgIcon(
              assetPath: IconConstants.copy,
              color: context.color.gray900,
              width: 28,
            ),
            showTrailing: false,
            onTap: onCopyCodePressed,
          ),
        ],
      ),
      heightRatio: 0.28,
    );
  }

  void showToast(
    BuildContext context,
    String message,
  ) {
    CustomToast.show(
      context: context,
      message: message,
      icon: IconConstants.copy,
      gravity: ToastGravity.TOP,
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
        leading = TagDay(
          day: tripRoom.dDay,
          color: labelColor,
          dayType: tripRoom.dDay < 1 ? TagDayType.duringTrip : TagDayType.dDay,
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
      children: [
        RoundThumbnailImage(
          imageUrl: tripRoom.thumbnail,
        ),
        const SizedBox(width: 12),
        _buildTripInfo(),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Builder(
              builder: (context) => TabUser(
                onPressed: () => onMemberTap?.call(context),
                memberCount: tripRoom.memberCount,
                isEnabled: false,
              ),
            ),
          ],
        ),
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
                  tripRoom.type.name.toUpperCase(),
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
          LinkButton(
            onPressed: onInvitePressed,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              label: "새 여행방 생성",
              onPressed: onCreatePressed,
            ),
          ),
        ],
      ),
    );
  }
}
