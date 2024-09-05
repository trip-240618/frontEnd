import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:tripStory/util/color.dart';

import '../../../../controller/historyState.dart';
import '../../../../util/font.dart';


class AlbumListPage extends StatefulWidget {
   AlbumListPage({super.key});

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  final hs = Get.put(HistoryState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: GestureDetector(
        //   behavior: HitTestBehavior.opaque,
        //   onTap: (){
        //     Get.back();
        //   },
        //   child: Container(
        //     child: SvgPicture.asset(
        //       'assets/icon/leftArrow.svg',
        //       fit: BoxFit.none,
        //     ),
        //   ),
        // ),
        title: GestureDetector(
          onTap: (){
            Get.to(()=>AlbumListPage(),transition: Transition.downToUp);
          },
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Row(
              children: [
                Spacer(),
                Text('모든 앨범',style: f16gray900w700),
                const SizedBox(width: 5),
                SvgPicture.asset(
                    'assets/icon/upArrow.svg',
                    height: 7,
                    colorFilter: ColorFilter.mode(gray900,BlendMode.srcIn)),
                // const SizedBox(width: 56),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      body: Obx(()=>Padding(
        padding: const EdgeInsets.only(left: 17,right: 17,top: 34),
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          cacheExtent: 5000,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 27,
            mainAxisSpacing: 34,
            childAspectRatio: 0.713,
          ),
          shrinkWrap: true,
          itemCount: hs.albums.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: GestureDetector(
                onTap:(){},
                child: hs.albums[index].images.length==0
                    ?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                        child: Stack(
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x26383838), // 그림자 색상 (16진수 색상 코드)
                                      offset: Offset(0, 4),    // 그림자의 위치 (X, Y)
                                      blurRadius: 5.3,          // 흐림 정도
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Center(child: SvgPicture.asset('assets/icon/camera.svg')),
                            ),
                          ),
                        ],
                      ),
                    ),
                        const SizedBox(height: 15),
                        Text('${hs.albums[index].name}',style: f14gray800w700,),
                        const SizedBox(height: 5),
                        Text('${hs.albums[index].images.length}',style: f12non400w500,),
                      ],
                   )
                    :Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x26383838), // 그림자 색상 (16진수 색상 코드)
                                        offset: Offset(0, 4),    // 그림자의 위치 (X, Y)
                                        blurRadius: 5.3,          // 흐림 정도
                                      ),
                                    ]
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  hs.selectAlbumIndex.value = index;
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: AssetEntityImage(
                                      gaplessPlayback: true,
                                      filterQuality: FilterQuality.high,
                                      isOriginal: false,
                                      thumbnailSize: ThumbnailSize.square(700),
                                      thumbnailFormat: ThumbnailFormat.png,
                                      hs.albums[index].images[0],
                                      width: Get.width*0.8,
                                      height: Get.height,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text('${hs.albums[index].name}',style: f14gray800w700,),
                        const SizedBox(height: 5),
                        Text('${hs.albums[index].images.length}',style: f12non400w500,),
                      ],
                    ),
              ),
            );
          },
        ),
      )),
    );
  }
}
