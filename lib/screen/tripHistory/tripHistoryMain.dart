import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/controller/historyState.dart';
import 'package:tripStory/util/color.dart';
import '../../component/history/customMarker.dart';
import '../../util/bottomSheetHeader.dart';
import '../../util/font.dart';

class TripHistoryMainPage extends StatefulWidget {
  const TripHistoryMainPage({super.key});

  @override
  State<TripHistoryMainPage> createState() => _TripHistoryMainPageState();
}

class _TripHistoryMainPageState extends State<TripHistoryMainPage> {
  final hs = Get.put(HistoryState());
  DraggableScrollableController scrollableController = DraggableScrollableController();
  ScrollController listScrollCon = ScrollController();
  final GlobalKey<ScaffoldState> modelScaffoldKey = GlobalKey<ScaffoldState>();
  Set<Marker> _markers = {};
  double currentHeight = 0.4;
  bool isInitialCameraMove = true;
  bool isListScroller = false;
  List tagList = ['도파민','맛집 탐방','액티비티','한달살이','새벽 감성','배낭 여행','힐링','미식가'];

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await addMarker(LatLng(36.35475233611197, 127.34170655688537));
      setState(() {});
    });
    super.initState();
  }

  Future<BitmapDescriptor> getCustomIcon(int index, String imageUrl) async {
    final double iconSize = 300.0;

    final File imageFile = await DefaultCacheManager().getSingleFile(imageUrl);
    final Uint8List imageBytes = await imageFile.readAsBytes();

    final widget = SizedBox(
      width: iconSize,
      height: 400,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text('$index', style: f20whitew700)),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Image.asset(
                "assets/icon/mapImage.png",
                width: iconSize,
                height: iconSize,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 100,
              left: 50,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final pngBytes = await createImageFromWidget(
      widget,
      logicalSize: Size(iconSize, iconSize),
      imageSize: Size(iconSize, iconSize),
    );

    return BitmapDescriptor.fromBytes(pngBytes);
  }

  Future<void> addMarker(LatLng position) async {
    List<LatLng> test = [
      LatLng(36.35475233611197, 127.34170655688537),
      LatLng(36.369355301533325, 127.3465953546253),
      LatLng(36.37698055405723, 127.38723847110654),
      LatLng(36.41435138948434, 127.40107085328566),
      LatLng(36.426725618175894, 127.38703931549783),
      LatLng(36.44842703850146, 127.42880857320041),
      LatLng(36.4279919474585, 127.39659122410552),
      LatLng(36.42694185772703, 127.38705154010651),
      LatLng(36.40360013422488, 127.44444792592536),
    ];
    List image = [
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FrMFkrkPO8Jqc6Mm7Vs4I?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FOsn4V5Z4xfHMmuiYPbKh?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FPJXkZvzei5R6GwdkrxP1?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FpnoARp13y5f1UetRXuPC?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FaVgN4qc74mWFs47ZeYYt?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FdYvEtzzpl5BfDJgOe8nY?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FF0bb70do8J4jA1McLghD?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FF0bb70do8J4jA1McLghD?alt=media',
    ];

    for(int i=0;i<9;i++){
      final icon = await getCustomIcon(i,image[i]);
      final marker = Marker(
          markerId: MarkerId(DateTime.now().toString()), // 각 마커마다 고유 ID 설정
          position: test[i],
          icon: icon,
          onTap: (){}
      );
      _markers.add(marker);
    }
  }

  Future<void> changeMarker() async {
    List<LatLng> test = [
      LatLng(36.35475233611197, 127.34170655688537),
      LatLng(36.369355301533325, 127.3465953546253),
      LatLng(36.37698055405723, 127.38723847110654),
      LatLng(36.41435138948434, 127.40107085328566),
      LatLng(36.426725618175894, 127.38703931549783),
      LatLng(36.44842703850146, 127.42880857320041),
      LatLng(36.4279919474585, 127.39659122410552),
      LatLng(36.42694185772703, 127.38705154010651),
      LatLng(36.40360013422488, 127.44444792592536),
    ];
    List image = [
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FrMFkrkPO8Jqc6Mm7Vs4I?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FOsn4V5Z4xfHMmuiYPbKh?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FPJXkZvzei5R6GwdkrxP1?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2FpnoARp13y5f1UetRXuPC?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FaVgN4qc74mWFs47ZeYYt?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FdYvEtzzpl5BfDJgOe8nY?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FF0bb70do8J4jA1McLghD?alt=media',
      'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2FF0bb70do8J4jA1McLghD?alt=media',
    ];
    _markers.clear();
    for(int i=0;i<3;i++){
      final icon = await getCustomIcon(i,image[i]);
      final marker = Marker(
          markerId: MarkerId(DateTime.now().toString()), // 각 마커마다 고유 ID 설정
          position: test[i],
          icon: icon,
          onTap: (){}
      );
      _markers.add(marker);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: modelScaffoldKey,
      body: Stack(
        children: [
          // GestureDetector(
          //   onTap: (){
          //     changeMarker();
          //   },
          //     child: Text('313121')),
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(hs.latitude.value, hs.longitude.value),
              zoom: 14.4746,
            ),
            markers: _markers.toSet(),
            onCameraMove: (CameraPosition position){
              if(!isInitialCameraMove){
                // scrollableController.animateTo(
                //     0.05,
                //     duration: const Duration(milliseconds: 1),
                //     curve: Curves.linear);
              }
              isInitialCameraMove = false;
              setState(() {});
            },
            onMapCreated: (GoogleMapController controller) {
              if (!hs.mapController.isCompleted) {
                hs.mapController.complete(controller);
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: DraggableScrollableSheet(
                initialChildSize: currentHeight,
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
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                              child: Column(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.circular(30)),
                                  ),
                                  const SizedBox(height: 27),
                                  Row(
                                    children: [
                                      Text('도쿄 즉흥 여행',style: f16gray800w700,),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: gray500)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                          child: Text('기록 추가',style: f12gray900w500,),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: 10,
                                    (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Get.width,
                                          height: 244,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: gray200),
                                            borderRadius: BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                offset: Offset(0, 0),
                                                blurRadius: 13.3,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Day ${index + 1}',style: f16gray800w600,),
                                                    const SizedBox(width: 9),
                                                    Text('2024.08.12',style: f12Gray600w500,),
                                                  ],
                                                ),
                                                const SizedBox(height: 18),
                                                Expanded(
                                                  child: ListView.builder(
                                                      itemCount: 10,
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemBuilder: (context, index) {
                                                        return Row(
                                                          children: [
                                                            Container(
                                                              width: 120,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2F1EjyruHeHaU6ZQpNe22L?alt=media',
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
                                                                      top:12,
                                                                      left:12,
                                                                      child: Container(
                                                                          width:25,
                                                                          height:25,
                                                                          decoration:BoxDecoration(
                                                                              color: Color(0xff56BBE6),
                                                                              shape: BoxShape.circle
                                                                          ),
                                                                          child: Center(child: Text('${index}',style: f14Whitew700,)))
                                                                  ),
                                                                  Positioned(
                                                                      bottom: 32,
                                                                      left:10,
                                                                      child:  Container(
                                                                        width: 16,
                                                                        height: 16,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle
                                                                        ),
                                                                        child: ClipOval(
                                                                          child: CachedNetworkImage(
                                                                            imageUrl: 'https://trip-story.s3.ap-northeast-2.amazonaws.com/test/6bb5a043-fd6f-4f00-8803-35e7823c3287',
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
                                                                      )
                                                                  ),
                                                                  Positioned(
                                                                    left:10,
                                                                    bottom:10,
                                                                    child: Wrap(
                                                                      direction: Axis.horizontal,
                                                                      alignment: WrapAlignment.start,
                                                                      spacing: 5,
                                                                      runSpacing: 5,
                                                                      children: ['벚꽃', '벚꽃여행dasdsa'].map((item) {
                                                                        return Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(30),
                                                                          ),
                                                                          child: Text(
                                                                            '#${item}',
                                                                            style: f12whitew500,
                                                                          ),
                                                                        );
                                                                      }).toList(
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(width: 8)
                                                          ],
                                                        );
                                                      }
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                })),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: 52,
              left: 20,
              right: 20,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: gray50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icon/search.svg'),
                      const SizedBox(width: 4),
                      Text('여행지를 검색해주세요',style: f14Gray500w400)
                    ],
                  ),
                ),
              )
          ),
          Positioned(
              top: 115,
              left: 20,
              right: 20,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 6,
                runSpacing: 5,
                children: tagList.map((item) {
                  return Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: '# ', style:TextStyle(color: pastelBlue)),
                                TextSpan(text: '${item}',style: f14gray800w600),
                              ])
                      ),
                    ),
                  );
                }).toList(
                ),
              )
          ),
        ],
      ),
    );
  }
}

