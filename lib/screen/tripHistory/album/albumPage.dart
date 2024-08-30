import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:tripStory/util/color.dart';
import '../../../controller/historyState.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final hs = Get.put(HistoryState());
  @override
  void initState() {
    hs.getAlbums();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('최근항목'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:20,right: 20),
        child: Column(
          children: [
            // Obx(()=>Expanded(
            //   child: GridView.builder(
            //     physics: const ClampingScrollPhysics(),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       crossAxisSpacing: 4,
            //       childAspectRatio: 0.82,
            //     ),
            //     itemCount: hs.albumList.value[hs.selectAlbumIndex.value].images.length,
            //     itemBuilder: (context, index) {
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(4),
            //         child: Stack(
            //           children: [
            //             index==0
            //                 ? Container(
            //               width: Get.width,
            //               height: 128,
            //               decoration: BoxDecoration(
            //                 color: gray300,
            //               ),
            //               child: SvgPicture.asset('assets/icon/camera.svg',fit: BoxFit.none,),
            //             )
            //                 :
            //             GestureDetector(
            //               onTap:(){
            //                 if(hs.selectAlbumList.value.contains(hs.albumList.value[0].images[index-1])){
            //                   hs.removeFromSelectedAlbum(hs.albumList.value[0].images[index-1]);
            //                 }else{
            //                   hs.addToSelectedAlbum(hs.albumList.value[0].images[index-1]);
            //                 }
            //                 print('전체 선택된 길이 ${hs.selectAlbumList.value.length}');
            //                 print('qwe${hs.selectAlbumList.value[0].images}');
            //               },
            //               child: AssetEntityImage(
            //                 width: Get.width,
            //                 height: 128,
            //                 hs.albumList.value[hs.selectAlbumIndex.value].images[index-1],
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //             Positioned(
            //                 top: 8,
            //                 right: 8,
            //                 child: Container(
            //                   width: 18,
            //                   height: 18,
            //                   decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       shape: BoxShape.circle
            //                   ),
            //                 )
            //             )
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}
