import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripHistory/history/tripHistoryDetail.dart';
import 'package:tripStory/util/color.dart';
import '../../../../component/appbar.dart';
import '../../../../util/font.dart';
import 'package:intl/intl.dart';
class TripHistoryList extends StatefulWidget {
  final bool? isAdd;
  final int? index;
  const TripHistoryList({super.key, this.isAdd=true, this.index=0});

  @override
  State<TripHistoryList> createState() => _TripHistoryListState();
}

class _TripHistoryListState extends State<TripHistoryList> {
  final ts = Get.put(TripState());
  final hs = Get.put(HistoryState());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        appBar: BackAppBar(text: '', onTap: () {
          if(widget.isAdd!){
            Get.back();
            Get.back();
            Get.back();
          }else{
            Get.back();
          }
        },color: Colors.white,),
        body: Obx(()=>Padding(
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
                  Text(
                    '${DateFormat('yyyy.MM.dd').format(DateTime.parse('${hs.historyList[widget.index!]['date']}'))}',
                    style: f12Gray800w500,
                  ),
                  // Text('${}',style: f12Gray800w500,)
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
                    itemCount: hs.historyList[widget.index!]['items'].length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>TripHistoryDetailPage(selectedIdx: hs.historyList[widget.index!]['items'][index]['id']));
                        },
                        child: Container(
                          width: 120,
                          child: Stack(
                            children: [
                              Positioned(
                                child: CachedNetworkImage(
                                  imageUrl: '${hs.historyList[widget.index!]['items'][index]['thumbnail']}',
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
                                    imageUrl: '${hs.historyList[widget.index!]['items'][index]['profileImage']}',
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
                                    Text('${hs.historyList[widget.index!]['items'][index]['likeCnt']}',style: f12whitew500,),
                                    const SizedBox(width: 8,),
                                    SvgPicture.asset('assets/icon/smallComment.svg'),
                                    const SizedBox(width: 3,),
                                    Text('${hs.historyList[widget.index!]['items'][index]['replyCnt']}',style: f12whitew500,),
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
          ),)),

      ),
    );
  }
}
