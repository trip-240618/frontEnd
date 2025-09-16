import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/helper/text_span_helper.dart';
import 'package:tripStory/presentation/common/appbar/base_appbar.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/icon/svg_icon.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({
    super.key,
  });

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  final ScrollController scrollController = ScrollController();
  bool isScoll = true;

  // Timer? _debounce;

  @override
  void initState() {
    // hs.getAlbums();
    scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    isScoll = false;
    // if (_debounce?.isActive ?? false) _debounce!.cancel();
    // _debounce = Timer(const Duration(milliseconds: 200), () {
    //   isScoll = true;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AlbumAppbar(
        title: "최근 엘범",
        selectedCount: 1,
        onTitlePressed: () {},
      ),
      // body: Stack(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      //       child: Column(
      //         children: [
      //           Obx(() => Expanded(
      //                 child: GridView.builder(
      //                   controller: scrollController,
      //                   physics: const ClampingScrollPhysics(),
      //                   addAutomaticKeepAlives: false,
      //                   cacheExtent: 5000,
      //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                     crossAxisCount: 3,
      //                     crossAxisSpacing: 3,
      //                     mainAxisSpacing: 3,
      //                     childAspectRatio: 1,
      //                   ),
      //                   shrinkWrap: true,
      //                   itemCount: hs.albums.isEmpty || hs.albums[hs.selectAlbumIndex.value].images.length == 0
      //                       ? 0
      //                       : hs.albums[hs.selectAlbumIndex.value].images.length,
      //                   itemBuilder: (context, index) {
      //                     return Stack(
      //                       fit: StackFit.expand,
      //                       children: [
      //                         if (index == 0)
      //                           GestureDetector(
      //                             onTap: () async {
      //                               bool isRequest = await hs.requestCameraPermission(context);
      //                               if (isRequest) {
      //                                 hs.getSingleCamera(ImageSource.camera, context);
      //                               }
      //                             },
      //                             child: Container(
      //                               width: Get.width,
      //                               height: 128,
      //                               decoration: BoxDecoration(
      //                                 color: gray50,
      //                               ),
      //                               child: SvgPicture.asset(
      //                                 'assets/icon/camera.svg',
      //                                 colorFilter: ColorFilter.mode(gray900, BlendMode.srcIn),
      //                                 fit: BoxFit.none,
      //                               ),
      //                             ),
      //                           )
      //                         else
      //                           GestureDetector(
      //                             onTap: () async {
      //                               if (hs.selectAlbumList.contains(hs.albums[0].images[index - 1])) {
      //                                 hs.removeFromSelectedAlbum(hs.albums[0].images[index - 1]);
      //                               } else {
      //                                 if (hs.selectAlbumList.length <= 9) {
      //                                   hs.addToSelectedAlbum(hs.albums[0].images[index - 1]);
      //                                 }
      //                               }
      //                             },
      //                             child: AssetEntityImage(
      //                               gaplessPlayback: true,
      //                               filterQuality: FilterQuality.high,
      //                               isOriginal: false,
      //                               thumbnailSize: ThumbnailSize.square(isScoll ? 500 : 25),
      //                               thumbnailFormat: ThumbnailFormat.png,
      //                               hs.albums[hs.selectAlbumIndex.value].images[index - 1],
      //                               fit: BoxFit.cover,
      //                             ),
      //                           ),
      //                         index == 0
      //                             ? SizedBox()
      //                             : Positioned(
      //                                 top: 8,
      //                                 right: 8,
      //                                 child: hs.selectAlbumList
      //                                         .contains(hs.albums[hs.selectAlbumIndex.value].images[index - 1])
      //                                     ? GestureDetector(
      //                                         onTap: () {
      //                                           if (hs.selectAlbumList.contains(hs.albums[0].images[index - 1])) {
      //                                             hs.removeFromSelectedAlbum(hs.albums[0].images[index - 1]);
      //                                           } else {
      //                                             if (hs.selectAlbumList.length <= 9) {
      //                                               hs.addToSelectedAlbum(hs.albums[0].images[index - 1]);
      //                                             }
      //                                           }
      //                                         },
      //                                         child: Container(
      //                                           width: 18,
      //                                           height: 18,
      //                                           decoration: BoxDecoration(color: gray900, shape: BoxShape.circle),
      //                                           child: SvgPicture.asset(
      //                                             'assets/icon/check2.svg',
      //                                             colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      //                                             width: 8,
      //                                             height: 6,
      //                                             fit: BoxFit.none,
      //                                           ),
      //                                         ),
      //                                       )
      //                                     : GestureDetector(
      //                                         onTap: () {
      //                                           if (hs.selectAlbumList.contains(hs.albums[0].images[index - 1])) {
      //                                             hs.removeFromSelectedAlbum(hs.albums[0].images[index - 1]);
      //                                           } else {
      //                                             if (hs.selectAlbumList.length <= 9) {
      //                                               hs.addToSelectedAlbum(hs.albums[0].images[index - 1]);
      //                                             }
      //                                           }
      //                                         },
      //                                         child: Container(
      //                                           width: 18,
      //                                           height: 18,
      //                                           decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      //                                         ),
      //                                       ))
      //                       ],
      //                     );
      //                   },
      //                 ),
      //               )),
      //         ],
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       child: Obx(() => Container(
      //           width: Get.width,
      //           decoration: BoxDecoration(
      //             color: Colors.white.withOpacity(0.8), // 불투명도 설정
      //           ),
      //           height: hs.selectAlbumList.length == 0 ? 120 : 180,
      //           child: hs.selectAlbumList.length == 0
      //               ? Center(
      //                   child: Text(
      //                   '사진은 최대 50장 업로드 가능합니다',
      //                   style: f16gray900w500,
      //                 ))
      //               : Padding(
      //                   padding: const EdgeInsets.only(bottom: 34, top: 8),
      //                   child: Column(
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 20, right: 20),
      //                         child: Container(
      //                           width: Get.width,
      //                           height: 70,
      //                           child: ReorderableListView.builder(
      //                             itemCount: hs.selectAlbumList.length,
      //                             scrollDirection: Axis.horizontal,
      //                             onReorder: (int oldIndex, int newIndex) {
      //                               if (newIndex > oldIndex) {
      //                                 newIndex -= 1;
      //                               }
      //                               final item = hs.selectAlbumList.removeAt(oldIndex);
      //                               hs.selectAlbumList.insert(newIndex, item);
      //                             },
      //                             itemBuilder: (context, index) {
      //                               return Row(
      //                                 key: ValueKey(hs.selectAlbumList[index]),
      //                                 children: [
      //                                   Stack(
      //                                     children: [
      //                                       Container(
      //                                         width: 72,
      //                                         height: 70,
      //                                         child: Stack(
      //                                           children: [
      //                                             Positioned(
      //                                               bottom: 0,
      //                                               child: ClipRRect(
      //                                                 borderRadius: BorderRadius.circular(4),
      //                                                 child: AssetEntityImage(
      //                                                   gaplessPlayback: true,
      //                                                   filterQuality: FilterQuality.high,
      //                                                   isOriginal: false,
      //                                                   width: 64,
      //                                                   height: 64,
      //                                                   thumbnailSize: ThumbnailSize.square(500),
      //                                                   thumbnailFormat: ThumbnailFormat.png,
      //                                                   hs.selectAlbumList[index],
      //                                                   fit: BoxFit.cover,
      //                                                 ),
      //                                               ),
      //                                             ),
      //                                             Positioned(
      //                                               top: 0,
      //                                               right: 0,
      //                                               child: GestureDetector(
      //                                                 onTap: () {
      //                                                   hs.removeFromSelectedAlbum(hs.selectAlbumList[index]);
      //                                                 },
      //                                                 child: SvgPicture.asset(
      //                                                   'assets/icon/minix.svg',
      //                                                   fit: BoxFit.contain,
      //                                                 ),
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       )
      //                                     ],
      //                                   ),
      //                                   const SizedBox(width: 8),
      //                                 ],
      //                               );
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                       const SizedBox(height: 8),
      //                       Spacer(),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 20, right: 20),
      //                         child: BlackCountContainer(
      //                           onTap: () {
      //                             hs.historyFileUpload(hs.selectAlbumList, context);
      //                             Get.to(() => TripHistoryAddPage());
      //                           },
      //                           title: '선택완료',
      //                           count: hs.selectAlbumList.length,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ))),
      //     ),
      //   ],
      // ),
      // bottomNavigationBar: Obx(() => Container(
      //     width: Get.width,
      //     decoration: BoxDecoration(
      //       color: Colors.white.withOpacity(0.8), // 불투명도 설정
      //     ),
      //     height: hs.selectAlbumList.length == 0 ? 120 : 250,
      //     child: hs.selectAlbumList.length == 0
      //         ? Center(
      //             child: Text(
      //             '사진은 최대 50장 업로드 가능합니다',
      //             style: f14Gray500w400,
      //           ))
      //         : Padding(
      //             padding: const EdgeInsets.only(left: 0, right: 0, top: 17, bottom: 34),
      //             child: Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 20, right: 20),
      //                   child: Container(
      //                     width: Get.width,
      //                     height: 100,
      //                     child: ReorderableListView.builder(
      //                       itemCount: hs.selectAlbumList.length,
      //                       scrollDirection: Axis.horizontal,
      //                       onReorder: (int oldIndex, int newIndex) {
      //                         if (newIndex > oldIndex) {
      //                           newIndex -= 1;
      //                         }
      //                         final item = hs.selectAlbumList.removeAt(oldIndex);
      //                         hs.selectAlbumList.insert(newIndex, item);
      //                       },
      //                       itemBuilder: (context, index) {
      //                         return Row(
      //                           key: ValueKey(hs.selectAlbumList[index]), // ReorderableListView requires a unique key
      //                           children: [
      //                             Stack(
      //                               children: [
      //                                 ClipRRect(
      //                                   borderRadius: BorderRadius.circular(4),
      //                                   child: AssetEntityImage(
      //                                     gaplessPlayback: true,
      //                                     filterQuality: FilterQuality.high,
      //                                     isOriginal: false,
      //                                     width: 80,
      //                                     height: 80,
      //                                     thumbnailSize: ThumbnailSize.square(isScoll ? 500 : 25),
      //                                     thumbnailFormat: ThumbnailFormat.png,
      //                                     hs.selectAlbumList[index],
      //                                     fit: BoxFit.cover,
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   top: 6,
      //                                   right: 6,
      //                                   child: GestureDetector(
      //                                     onTap: () {
      //                                       hs.removeFromSelectedAlbum(hs.selectAlbumList[index]);
      //                                     },
      //                                     child: SvgPicture.asset('assets/icon/xicon.svg'),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             const SizedBox(width: 8),
      //                           ],
      //                         );
      //                       },
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(height: 8),
      //                 Text('길게 눌러 순서를 변경할 수 있어요.', style: f14Gray500w400),
      //                 const SizedBox(height: 8),
      //                 Spacer(),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 20, right: 20),
      //                   child: BlackCountContainer(
      //                     onTap: () {
      //                       Get.to(() => TripHistoryAddPage());
      //                     },
      //                     title: '선택완료',
      //                     count: hs.selectAlbumList.length,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ))),
    );
  }
}

class _AlbumAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int selectedCount;
  final VoidCallback onTitlePressed;

  const _AlbumAppbar({
    required this.title,
    required this.selectedCount,
    required this.onTitlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAppbar(
      color: context.color.white,
      leadingWidget: AppIconButton(
        assetPath: IconConstants.leftArrow,
        onTap: () => Get.back(),
      ),
      titleWidget: GestureDetector(
        onTap: onTitlePressed,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: context.style.body1Normal,
              ),
              SvgIcon(
                assetPath: IconConstants.underArrow,
              ),
            ],
          ),
        ),
      ),
      actionWidget: Text.rich(
        TextSpanHelper.toSplitText(
          text: "$selectedCount/50",
          delimiter: "/",
          firstStyle: selectedCount == 0
              ? context.style.caption1.copyWith(
                  color: context.color.gray400,
                )
              : context.style.caption1.copyWith(
                  color: context.color.gray900,
                ),
          secondStyle: context.style.caption1.copyWith(
            color: context.color.gray400,
          ),
          delimiterStyle: context.style.caption1.copyWith(
            color: context.color.gray400,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
