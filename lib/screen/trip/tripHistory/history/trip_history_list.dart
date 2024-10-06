import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripHistory/history/tripHistoryDetail.dart';
import 'package:tripStory/util/color.dart';

import '../../../../component/appbar.dart';
import '../../../../util/font.dart';

class TripHistoryList extends StatefulWidget {
  const TripHistoryList({super.key});

  @override
  State<TripHistoryList> createState() => _TripHistoryListState();
}

class _TripHistoryListState extends State<TripHistoryList> {
  final ts = Get.put(TripState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(text: '', onTap: () {
        Get.back();
        Get.back();
        Get.back();
      },color: Colors.white,),
      body:
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(color: pastelBlue,width: 1.5),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text('Day 1',style: f12blueW700)),
                ),
                const SizedBox(width: 6,),
                Text('2024.05.10',style: f12Gray800w500,)
              ],
            ),
            const SizedBox(height: 16,),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0, // 열 간의 간격
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.793,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>TripHistoryDetailPage());
                      },
                      child: Container(
                        width: 120,
                        child: Stack(
                          children: [
                            Positioned(
                              child: CachedNetworkImage(
                                //imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2F1EjyruHeHaU6ZQpNe22L?alt=media',
                                imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/foodImage.jpeg?alt=media',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
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
                            Positioned(
                              top:12,
                              right:12,
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CachedNetworkImage(
                                  imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/profile.png?alt=media',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              left:12,
                              bottom:12,
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icon/smallheart.svg'),
                                  const SizedBox(width: 3,),
                                  Text('0',style: f12whitew500,),
                                  const SizedBox(width: 8,),
                                  SvgPicture.asset('assets/icon/smallComment.svg'),
                                  const SizedBox(width: 3,),
                                  Text('0',style: f12whitew500,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
              ),
            ),


          ],
        ),),

    );
  }
}
