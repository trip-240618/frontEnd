import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/bottomSheetHeader.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/extension/string_extension.dart';
import 'package:tripStory/domain/entities/histories_entity.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';
import 'package:tripStory/presentation/common/tag/tag_day.dart';
import 'package:tripStory/presentation/trip/controllers/history_main_controller.dart';

class HistoryMainView extends StatefulWidget {
  const HistoryMainView({super.key});

  @override
  State<HistoryMainView> createState() => _HistoryMainViewState();
}

class _HistoryMainViewState extends State<HistoryMainView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryMainController>(
      builder: (controller) {
        final state = controller.state;

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(state.currentLatitude, state.currentLongitude),
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
                        ),
                        _BottomSheetContent(
                          labelColor: controller.tripRoomInfo?.labelColor.toColor() ?? context.color.blue,
                          histories: state.histories,
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
    return GestureDetector(
      onTap: onSearchBarPressed,
      child: Container(
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

  const _BottomSheetHeader({
    required this.tripRoomName,
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
                      onTap: () {},
                    ),
                    Text(
                      tripRoomName,
                      style: context.style.headline3,
                    ),
                    AppIconButton(
                      assetPath: IconConstants.roundPlus,
                      onTap: () {},
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

  const _BottomSheetContent({
    required this.labelColor,
    required this.histories,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: histories.length,
          (context, index) {
            final history = histories[index].historyList;
            final photoDate = histories[index].photoDate;

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
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 16,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // if (hs.historyList[index]['historyList'].length != 0) {
                            //   Get.to(() => TripHistoryList(isAdd: false, index: index));
                            // }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                children: [
                                  TagDay(
                                    day: index + 1,
                                    color: labelColor,
                                    dayType: TagDayType.day,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    photoDate,
                                    style: context.style.caption1,
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: context.color.gray400,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${history.length}",
                                        style: context.style.caption1.copyWith(
                                          color: context.color.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: history.length,
                              scrollDirection: Axis.horizontal,
                              addRepaintBoundaries: false,
                              addAutomaticKeepAlives: false,
                              itemBuilder: (context, idx) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Get.to(() => TripHistoryDetailPage(
                                        //       selectedIdx: idx,
                                        //       dayIdx: index,
                                        //       historyId: hs.historyList[index]['historyList'][idx]
                                        //           ['id'],
                                        //     ));
                                      },
                                      child: Container(
                                        width: 120,
                                        child: Stack(
                                          children: [
                                            // Positioned(
                                            //   child: hs.historyList[index]['historyList'][idx]
                                            //               ['thumbnail'] ==
                                            //           ''
                                            //       ? DefaultProfileScreen(context)
                                            //       : CachedNetworkImage(
                                            //           maxHeightDiskCache: 350,
                                            //           maxWidthDiskCache: 350,
                                            //           imageUrl:
                                            //               '${hs.historyList[index]['historyList'][idx]['thumbnail']}',
                                            //           imageBuilder: (context, imageProvider) =>
                                            //               Container(
                                            //             decoration: BoxDecoration(
                                            //               borderRadius: BorderRadius.circular(4),
                                            //               image: DecorationImage(
                                            //                   image: imageProvider,
                                            //                   fit: BoxFit.cover),
                                            //             ),
                                            //           ),
                                            //           errorWidget: (context, url, error) =>
                                            //               DefaultProfileScreen(context),
                                            //         ),
                                            // ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Color(0xff212121).withOpacity(0.5),
                                                    ],
                                                    stops: [0.54, 1],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   top: 8,
                                            //   right: 8,
                                            //   child: Container(
                                            //     width: 20,
                                            //     height: 20,
                                            //     child: hs.historyList[index]['historyList'][idx]
                                            //                 ['profileImage'] ==
                                            //             ''
                                            //         ? DefaultProfileScreen(context)
                                            //         : CachedNetworkImage(
                                            //             imageUrl:
                                            //                 '${hs.historyList[index]['historyList'][idx]['profileImage']}',
                                            //             imageBuilder: (context, imageProvider) =>
                                            //                 Container(
                                            //               decoration: BoxDecoration(
                                            //                 borderRadius: BorderRadius.circular(4),
                                            //                 image: DecorationImage(
                                            //                     image: imageProvider,
                                            //                     fit: BoxFit.fill),
                                            //               ),
                                            //             ),
                                            //             errorWidget: (context, url, error) =>
                                            //                 DefaultProfileScreen(context),
                                            //           ),
                                            //   ),
                                            // ),
                                            // Positioned(
                                            //   left: 8,
                                            //   bottom: 8,
                                            //   child: Row(
                                            //     children: [
                                            //       SvgPicture.asset('assets/icon/smallheart.svg'),
                                            //       const SizedBox(
                                            //         width: 3,
                                            //       ),
                                            //       Text(
                                            //         '${hs.historyList[index]['historyList'][idx]['likeCnt']}',
                                            //         style: f12whitew500,
                                            //       ),
                                            //       const SizedBox(
                                            //         width: 8,
                                            //       ),
                                            //       SvgPicture.asset('assets/icon/smallComment.svg'),
                                            //       const SizedBox(
                                            //         width: 3,
                                            //       ),
                                            //       Text(
                                            //         '${hs.historyList[index]['historyList'][idx]['replyCnt']}',
                                            //         style: f12whitew500,
                                            //       ),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8)
                                  ],
                                );
                              }),
                        ),
                        // hs.historyList[index]['historyList'].length == 0
                        //     ? const SizedBox()
                        //     : const SizedBox(
                        //   height: 16,
                        // ),
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
