import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:tripStory/util/color.dart';
import '../../../../component/bottomContainer.dart';
import '../../../../controller/historyState.dart';
import '../../../../util/font.dart';
import '../history/tripHistoryAdd.dart';
import 'albumListPage.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final hs = Get.put(HistoryState());
  final ScrollController scrollController = ScrollController();
  bool isScoll = true;
  Timer? _debounce;
  @override
  void initState() {
    hs.getAlbums();
    scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    isScoll = false;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      isScoll = true;
      setState(() {});
    });
    // if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
    //   hs.loadMoreImages(hs.totalAlbumList[0]);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: (){
              Get.to(()=>AlbumListPage(),transition: Transition.downToUp);
            },
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/icon/leftArrow.svg',
                    fit: BoxFit.none,
                  ),
                ),
                Spacer(),
                Obx(() => Text(
                  hs.albums.isNotEmpty && hs.albums[hs.selectAlbumIndex.value].name.isNotEmpty
                      ? '${hs.albums[hs.selectAlbumIndex.value].name}'
                      : '',
                  style: f16gray900w700,
                )),
                const SizedBox(width: 5),
                SvgPicture.asset(
                    'assets/icon/underArrow.svg',
                    colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:20,right: 20,top: 20),
        child: Stack(
          children: [
            Column(
            children: [
              Obx(()=>Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  cacheExtent: 5000,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: hs.albums.isEmpty||hs.albums[hs.selectAlbumIndex.value].images.length==0?0:hs.albums[hs.selectAlbumIndex.value].images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          index==0
                              ? Container(
                            width: Get.width,
                            height: 128,
                            decoration: BoxDecoration(
                              color: gray300,
                            ),
                            child: SvgPicture.asset('assets/icon/camera.svg',fit: BoxFit.none,),
                          )
                              : GestureDetector(
                            onTap:()async{
                              // printExifOf(hs.albums[0].images[index-1]);
                              if(hs.selectAlbumList.contains(hs.albums[0].images[index-1])){
                                hs.removeFromSelectedAlbum(hs.albums[0].images[index-1]);
                              }else{
                                hs.addToSelectedAlbum(hs.albums[0].images[index-1]);
                              }
                            },
                            child: AssetEntityImage(
                              gaplessPlayback: true,
                              filterQuality: FilterQuality.high,
                              isOriginal: false,
                              thumbnailSize: ThumbnailSize.square(isScoll?500:25),
                              thumbnailFormat: ThumbnailFormat.png,
                              hs.albums[hs.selectAlbumIndex.value].images[index-1],
                              fit: BoxFit.cover,
                            ),
                          ),
                          index==0?SizedBox():
                          Positioned(
                              top: 8,
                              right: 8,
                              child: hs.selectAlbumList.contains(hs.albums[hs.selectAlbumIndex.value].images[index-1])
                                  ?Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    color: mainRed,
                                    shape: BoxShape.circle
                                ),
                                child: SvgPicture.asset('assets/icon/check2.svg',
                                  colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn),
                                  width: 8,height: 6,fit: BoxFit.none,),
                              )
                                  :Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  },
                ),
              )),
            ],
          ),
            // Positioned(
            //   bottom: 0,
            //   child: Obx(()=>Container(
            //       width: Get.width,
            //       decoration: BoxDecoration(
            //         color: Colors.white.withOpacity(0.8), // 불투명도 설정
            //       ),
            //       height: hs.selectAlbumList.length==0?120:250,
            //       child: hs.selectAlbumList.length==0
            //           ? Center(child: Text('사진은 최대 50장 업로드 가능합니다',style: f14Gray500w400,))
            //           : Padding(
            //         padding: const EdgeInsets.only(left: 0,right: 0,top: 17,bottom: 34),
            //         child: Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(left: 20,right: 20),
            //               child: Container(
            //                 width: Get.width,
            //                 height: 100,
            //                 child: ReorderableListView.builder(
            //                   itemCount: hs.selectAlbumList.length,
            //                   scrollDirection: Axis.horizontal,
            //                   onReorder: (int oldIndex, int newIndex) {
            //                     if (newIndex > oldIndex) {
            //                       newIndex -= 1;
            //                     }
            //                     final item = hs.selectAlbumList.removeAt(oldIndex);
            //                     hs.selectAlbumList.insert(newIndex, item);
            //                   },
            //                   itemBuilder: (context, index) {
            //                     return Row(
            //                       key: ValueKey(hs.selectAlbumList[index]), // ReorderableListView requires a unique key
            //                       children: [
            //                         Stack(
            //                           children: [
            //                             ClipRRect(
            //                               borderRadius: BorderRadius.circular(4),
            //                               child: AssetEntityImage(
            //                                 gaplessPlayback: true,
            //                                 filterQuality: FilterQuality.high,
            //                                 isOriginal: false,
            //                                 width: 80,
            //                                 height: 80,
            //                                 thumbnailSize: ThumbnailSize.square(isScoll ? 500 : 25),
            //                                 thumbnailFormat: ThumbnailFormat.png,
            //                                 hs.selectAlbumList[index],
            //                                 fit: BoxFit.cover,
            //                               ),
            //                             ),
            //                             Positioned(
            //                               top: 6,
            //                               right: 6,
            //                               child: GestureDetector(
            //                                 onTap: () {
            //                                   hs.removeFromSelectedAlbum(hs.selectAlbumList[index]);
            //                                 },
            //                                 child: SvgPicture.asset('assets/icon/xicon.svg'),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         const SizedBox(width: 8),
            //                       ],
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(height: 8),
            //             Text('길게 눌러 순서를 변경할 수 있어요.', style: f14Gray500w400),
            //             const SizedBox(height: 8),
            //             Spacer(),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 20,right: 20),
            //               child: BlackCountContainer(onTap: (){
            //                 Get.to(()=>TripHistoryAddPage());
            //               },title: '선택완료',count: hs.selectAlbumList.length,),
            //             ),
            //           ],
            //         ),
            //       )
            //   )),
            // ),
          ],
        ),
      ),
      bottomNavigationBar:Obx(()=>Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), // 불투명도 설정
        ),
        height: hs.selectAlbumList.length==0?120:250,
        child: hs.selectAlbumList.length==0
            ? Center(child: Text('사진은 최대 50장 업로드 가능합니다',style: f14Gray500w400,))
            : Padding(
              padding: const EdgeInsets.only(left: 0,right: 0,top: 17,bottom: 34),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      width: Get.width,
                      height: 100,
                      child: ReorderableListView.builder(
                        itemCount: hs.selectAlbumList.length,
                        scrollDirection: Axis.horizontal,
                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = hs.selectAlbumList.removeAt(oldIndex);
                          hs.selectAlbumList.insert(newIndex, item);
                        },
                        itemBuilder: (context, index) {
                          return Row(
                            key: ValueKey(hs.selectAlbumList[index]), // ReorderableListView requires a unique key
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: AssetEntityImage(
                                      gaplessPlayback: true,
                                      filterQuality: FilterQuality.high,
                                      isOriginal: false,
                                      width: 80,
                                      height: 80,
                                      thumbnailSize: ThumbnailSize.square(isScoll ? 500 : 25),
                                      thumbnailFormat: ThumbnailFormat.png,
                                      hs.selectAlbumList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: GestureDetector(
                                      onTap: () {
                                        hs.removeFromSelectedAlbum(hs.selectAlbumList[index]);
                                      },
                                      child: SvgPicture.asset('assets/icon/xicon.svg'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('길게 눌러 순서를 변경할 수 있어요.', style: f14Gray500w400),
                  const SizedBox(height: 8),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: BlackCountContainer(onTap: (){
                      Get.to(()=>TripHistoryAddPage());
                    },title: '선택완료',count: hs.selectAlbumList.length,),
                  ),
                ],
              ),
            )
      )),
    );
  }
}
