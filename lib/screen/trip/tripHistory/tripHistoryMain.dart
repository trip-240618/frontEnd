import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/app/permission/permission.dart';
import 'package:tripStory/component/dialog/daySelect.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/controller/MapState.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/trip/tripHistory/search/search_history_page.dart';
import 'package:tripStory/util/color.dart';
import '../../../component/empty/emptyScreen.dart';
import '../../../controller/mainState.dart';
import '../../../util/bottomSheetHeader.dart';
import '../../../util/font.dart';
import 'package:intl/intl.dart' as intl;
import 'history/tripHistoryDetail.dart';
import 'history/trip_history_list.dart';

class TripHistoryMainPage extends StatefulWidget {
  const TripHistoryMainPage({super.key});

  @override
  State<TripHistoryMainPage> createState() => _TripHistoryMainPageState();
}

class _TripHistoryMainPageState extends State<TripHistoryMainPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ms = Get.find<MainState>();
  final hs = Get.find<HistoryState>();
  final ts = Get.find<TripState>();
  final maps = Get.find<MapState>();
  DraggableScrollableController scrollableController = DraggableScrollableController();
  ScrollController listScrollCon = ScrollController();
  final GlobalKey<ScaffoldState> modelScaffoldKey = GlobalKey<ScaffoldState>();
  bool isInitialCameraMove = true;
  bool isListScroller = false;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await maps.getCurrentLocation(context);
      // await hs.getHistoryList(ts.selectTripList[0]['id']);
      // maps.addMarkersFromHistory();
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: modelScaffoldKey,
      body: isLoading?Center(child: LoadingWidget()):Obx(()=>Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(maps.latitude.value, maps.longitude.value),
              zoom: 14.4746,
            ),
            markers: maps.markers.toSet(),
            onCameraMove: maps.manager.onCameraMove,
            onCameraIdle: maps.manager.updateMap,
            onMapCreated: (GoogleMapController controller) {
              if (!maps.mapController.isCompleted) {
                maps.mapController.complete(controller);
                maps.manager.setMapId(controller.mapId);
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                //color: Theme.of(context).canvasColor,
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
                controller: scrollableController,
                snapSizes: [0.1, 0.4, 0.75],
                builder: (context, scrollController) {
                  return CustomScrollView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverPersistentHeader(
                        floating: false,
                        delegate: CustomSliverPersistentHeaderDelegate(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.circular(30)),
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: ()async{
                                            switch (ms.selectIdx.value) {
                                              case 0:
                                                await ms.getComingTrip();
                                                break;
                                              case 1:
                                                await ms.getLastTrip();
                                                break;
                                              case 2:
                                                await ms.getBookMarkTrip();
                                                break;
                                              default:
                                                break;
                                            }
                                            Get.back();
                                          },
                                          child: SvgPicture.asset('assets/icon/home.svg', color: gray900,)),
                                      Spacer(),
                                      Text('${ts.selectTripList[0]['name']}',style: f18Gray900w600,),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: ()async{
                                            bool isRequest = await requestPhotoMangerPermission(context);
                                            if(isRequest){
                                              SelectDayDialog(context, '', (){});
                                            }
                                          },
                                          child: SvgPicture.asset('assets/icon/enabledRoundPlus.svg')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(()=>SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: hs.historyList.length,
                                    (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: Get.width,
                                        height: hs.historyList[index]['historyList'].length==0?56:222,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            top: BorderSide(color: gray200, width: 0.5),
                                            bottom: BorderSide(color: gray200, width: 0.5),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,top: 16),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  if(hs.historyList[index]['historyList'].length!=0){
                                                   Get.to(()=>TripHistoryList(isAdd: false,index: index));
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 20),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              border: Border.all(
                                                                  color: Color(ts.selectTripList[0]['labelColor']), width: 1
                                                              ),
                                                              borderRadius: BorderRadius.circular(100)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                                                            child: Text('Day ${index + 1}', style: f12mainw700(Color(ts.selectTripList[0]['labelColor'])),),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 6,),
                                                        Text(
                                                            '${intl.DateFormat('yyyy.MM.dd').format(DateTime.parse('${hs.historyList[index]['photoDate']}'))}',
                                                          style: f12Gray800w500,
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                              color: hs.historyList[index]['historyList'].length==0?gray400:Color(ts.selectTripList[0]['labelColor']),
                                                              borderRadius: BorderRadius.circular(100),
                                                            ),
                                                            child: Center(child: Text('${hs.historyList[index]['historyList'].length}', style: f11whitew600,))),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              hs.historyList[index]['historyList'].length==0?const SizedBox():const SizedBox(height: 16,),
                                              Obx(()=>Expanded(
                                                child: ListView.builder(
                                                    itemCount: hs.historyList[index]['historyList'].length,
                                                    scrollDirection: Axis.horizontal,
                                                    addRepaintBoundaries: false,
                                                    addAutomaticKeepAlives: false,
                                                    itemBuilder: (context, idx) {
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap:(){
                                                              Get.to(()=>TripHistoryDetailPage(
                                                                selectedIdx: idx,
                                                                dayIdx: index,
                                                                historyId: hs.historyList[index]['historyList'][idx]['id'],
                                                              ));
                                                            },
                                                            child: Container(
                                                              width: 120,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    child: hs.historyList[index]['historyList'][idx]['thumbnail']==''
                                                                        ?DefaultProfileScreen(context)
                                                                        :CachedNetworkImage(
                                                                          maxHeightDiskCache: 350,
                                                                          maxWidthDiskCache: 350,
                                                                          imageUrl: '${hs.historyList[index]['historyList'][idx]['thumbnail']}',
                                                                          imageBuilder: (context, imageProvider) => Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(4),
                                                                          image: DecorationImage(
                                                                              image: imageProvider,
                                                                              fit: BoxFit.cover
                                                                          ),
                                                                        ),
                                                                        ),
                                                                        errorWidget: (context, url, error) => DefaultProfileScreen(context),
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
                                                                    top:8,
                                                                    right:8,
                                                                    child: Container(
                                                                      width: 20,
                                                                      height: 20,
                                                                      child: hs.historyList[index]['historyList'][idx]['profileImage']==''?DefaultProfileScreen(context):CachedNetworkImage(
                                                                        imageUrl: '${hs.historyList[index]['historyList'][idx]['profileImage']}',
                                                                        imageBuilder: (context, imageProvider) => Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(4),
                                                                            image: DecorationImage(
                                                                                image: imageProvider,
                                                                                fit: BoxFit.fill
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        errorWidget: (context, url, error) => DefaultProfileScreen(context),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left:8,
                                                                    bottom:8,
                                                                    child: Row(
                                                                      children: [
                                                                        SvgPicture.asset('assets/icon/smallheart.svg'),
                                                                        const SizedBox(width: 3,),
                                                                        Text('${hs.historyList[index]['historyList'][idx]['likeCnt']}',style: f12whitew500,),
                                                                        const SizedBox(width: 8,),
                                                                        SvgPicture.asset('assets/icon/smallComment.svg'),
                                                                        const SizedBox(width: 3,),
                                                                        Text('${hs.historyList[index]['historyList'][idx]['replyCnt']}',style: f12whitew500,),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8)
                                                        ],
                                                      );
                                                    }
                                                ),
                                              )),
                                              hs.historyList[index]['historyList'].length==0?const SizedBox():const SizedBox(height: 16,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                      ))
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: 57,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: (){Get.to(()=>SearchHistoryPage());},
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                      color: gray50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: gray200),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x2626261A).withOpacity(0.1),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                        BoxShadow(
                          color: Color(0x26262617).withOpacity(0.09),
                          offset: Offset(0, 3),
                          blurRadius: 3,
                        ),
                        BoxShadow(
                          color: Color(0x2626260D).withOpacity(0.05),
                          offset: Offset(0, 7),
                          blurRadius: 4,
                        ),
                        BoxShadow(
                          color: Color(0x26262603).withOpacity(0.01),
                          offset: Offset(0, 13),
                          blurRadius: 5,
                        ),
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icon/search.svg', color: Color(ts.selectTripList[0]['labelColor']),),
                        const SizedBox(width: 4),
                        Text('태그, 닉네임으로 사진을 검색해보세요',style: f15gray400w500)
                      ],
                    ),
                  ),
                ),
              )
          ),
          // Positioned(
          //     top: 115,
          //     left: 20,
          //     right: 20,
          //     child: Wrap(
          //       direction: Axis.horizontal,
          //       alignment: WrapAlignment.start,
          //       spacing: 6,
          //       runSpacing: 5,
          //       children: tagList.map((item) {
          //         return Container(
          //           height: 28,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
          //             child: RichText(
          //                 text: TextSpan(
          //                     children: [
          //                       TextSpan(text: '# ', style:TextStyle(color: pastelBlue)),
          //                       TextSpan(text: '${item}',style: f14gray800w600),
          //                     ])
          //             ),
          //           ),
          //         );
          //       }).toList(
          //       ),
          //     )
          // ),
        ],
      )),
    );
  }
}

