import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/controller/jPlanState.dart';
import 'package:tripStory/util/color.dart';
import '../../../util/font.dart';

class JSchedulePage extends StatefulWidget {
  const JSchedulePage({super.key});

  @override
  State<JSchedulePage> createState() => _JSchedulePageState();
}

class _JSchedulePageState extends State<JSchedulePage> {
  final js = Get.put(JPlanState());
  int selectIdx = 0;
  String startTime = '2024-08-01';
  String endTime = '2024-08-30';
  int totalDateLength = 0;
  ScrollController scrollController = ScrollController();
  Set<Marker> _markers = {};
  bool isSorting = false;
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      diffDate();
    });
    super.initState();
  }
  void diffDate(){
    // 날짜 형식 파서
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime startDate = dateFormat.parse(startTime);
    DateTime endDate = dateFormat.parse(endTime);

    // 날짜 사이의 차이 계산
    totalDateLength = endDate.difference(startDate).inDays + 1;
    setState(() {});
    print('?? ${totalDateLength}');
  }
// 스크롤을 특정 인덱스로 이동시키는 함수
  void scrollToIndex(int index) {
    double itemWidth = 40 + 12;
    double scrollOffset = itemWidth * index;

    scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                      child: SvgPicture.asset('assets/icon/home.svg')),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,  // Row의 수직 정렬을 가운데로
                      mainAxisAlignment: MainAxisAlignment.center,    // Row의 수평 정렬을 가운데로
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: gray200,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'J',
                              style: f12gray400W700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '오사카 일본 여행아니지',
                            style: f16gray600w700,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 24,
                      child: SvgPicture.asset('assets/icon/dot.svg')),
                ],
              ),
              const SizedBox(height: 4),
              Text('2024.05.10 ~ 2024.05.14',style: f12Gray500w500,)
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height:24,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          // SvgPicture.asset(
                          //   width: 25,
                          //   height: 25,
                          //   fit: BoxFit.fill,
                          //   'assets/icon/user.svg',
                          // ),
                          index==9?SizedBox():SizedBox(width: 4)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              height: 72,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: totalDateLength,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      selectIdx == index
                          ?  Column(
                        children: [
                            Text('Day ${'${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}'}',style: f16gray400w700),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Container(
                              width:40,
                              decoration: BoxDecoration(
                                  color: gray400,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f12whitew500,),
                                    Text('${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f14Whitew700,)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                          :  GestureDetector(
                            onTap:(){
                             selectIdx = index;
                             scrollToIndex(index);
                             setState(() {});
                            },
                            child: Column(
                            children: [
                              Expanded(
                               child: Container(
                                width:40,
                                color:Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('${DateFormat('E', 'ko').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f12Gray400w500,),
                                      Text('${DateFormat('d').format(DateFormat('yyyy-MM-dd').parse(startTime).add(Duration(days: index)))}',style: f14gray400w700,)
                                    ],
                                  ),
                                ),
                              ),
                             )
                            ],
                          ),
                        ),
                      const SizedBox(width: 12)
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Obx(()=>Container(
            width: Get.width,
            height: js.isGoogleExpanded.value?154:0,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(js.latitude.value, js.longitude.value),
                zoom: 14.4746,
              ),
              markers: _markers.toSet(),
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                if (!js.mapController.isCompleted) {
                  js.mapController.complete(controller);
                }
              },
            ),
          )),
          const SizedBox(height: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              js.isGoogleExpanded.value = !js.isGoogleExpanded.value;
            },
              child: Center(
                  child: Container(
                      child: SvgPicture.asset('assets/icon/wideUnderArrow.svg')))
          ),
          Obx(()=>Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      js.isSorting.value = !js.isSorting.value;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/icon/sort.svg',colorFilter:
                        ColorFilter.mode(
                          js.isSorting.value?gray600:gray400, // 원하는 색상으로 변경
                          BlendMode.srcIn, // 색상을 적용하는 블렌드 모드
                        ),),
                        Text('편집',style: js.isSorting.value?f12Gray600w600:f12Gray400w500,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Expanded(
                    child: ReorderableListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      buildDefaultDragHandles: false,
                      itemBuilder: (context,index) {
                        return Column(
                          key: Key('$index'),
                          children: [
                            ReorderableDragStartListener(
                              index:index,
                              enabled: js.isSorting.value?true:false,
                              child: Container(
                                width:Get.width,
                                child: Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: gray100,
                                          border: Border.all(color: gray200),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),    // 좌측 상단 반경 4px
                                            topRight: Radius.circular(0),   // 우측 상단 반경 0px
                                            bottomRight: Radius.circular(0),// 우측 하단 반경 0px
                                            bottomLeft: Radius.circular(4), // 좌측 하단 반경 4px
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
                                          child: Text('07:20',style: f12Gray400w500,),
                                        )),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: gray200),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),    // 좌측 상단 반경 4px
                                            topRight: Radius.circular(4),   // 우측 상단 반경 0px
                                            bottomRight: Radius.circular(4),// 우측 하단 반경 0px
                                            bottomLeft: Radius.circular(0), // 좌측 하단 반경 4px
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('항공편 KE371 도쿄행 인천 출발',style: f12Gray400w500,),
                                              Spacer(),
                                              SvgPicture.asset('assets/icon/ellipsis.svg')
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 4)
                          ],
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        // setState(() {
                        //   if(oldIndex<newIndex){
                        //     newIndex -= 1;
                        //   }
                        //   changed = false;
                        //   var element = list.removeAt(oldIndex);
                        //   list.insert(newIndex,element);
                        //   changeIndex(oldIndex, newIndex);
                        // });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
