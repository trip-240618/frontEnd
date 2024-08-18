import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/controller/historyState.dart';
import '../../component/history/customMarker.dart';
import '../../util/font.dart';

class TripHistoryMainPage extends StatefulWidget {
  const TripHistoryMainPage({super.key});

  @override
  State<TripHistoryMainPage> createState() => _TripHistoryMainPageState();
}

class _TripHistoryMainPageState extends State<TripHistoryMainPage> {
  final hs = Get.put(HistoryState());
  Set<Marker> _markers = {};
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

    // 1. 다운로드하여 캐시에 저장
    final File imageFile = await DefaultCacheManager().getSingleFile(imageUrl);
    final Uint8List imageBytes = await imageFile.readAsBytes();

    final imageProvider = MemoryImage(imageBytes);
    print('??? ${imageFile}');
    // 3. 위젯을 정의합니다.
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
      setState(() {

      });
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
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              changeMarker();
            },
              child: Text('313121')),
          Container(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(hs.latitude.value, hs.longitude.value),
                zoom: 14.4746,
              ),
              markers: _markers.toSet(),
              onMapCreated: (GoogleMapController controller) {
                if (!hs.mapController.isCompleted) {
                  hs.mapController.complete(controller);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
