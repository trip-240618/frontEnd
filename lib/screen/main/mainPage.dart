import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/app/api/testApi.dart';
import 'package:tripStory/app/api/userApi.dart';
import 'package:tripStory/component/bottomModals.dart';
import 'package:tripStory/screen/main/bookMark.dart';
import 'package:tripStory/screen/main/commingTrip.dart';
import 'package:tripStory/screen/main/pastTrip.dart';
import 'package:tripStory/screen/trip/bottomNavigator.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/main/tripAdd/tripRoomAdd.dart';
import 'package:tripStory/screen/myPage/myPage.dart';
import '../../app/config/dio_client.dart';
import '../../util/color.dart';
import '../../util/font.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainState ms = Get.put(MainState());
  final dioClient = DioClient();
  final apiUserClient = ApiUserClient(DioClient());
  final apiTestCli = ApiTestClient(DioClient());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: gray50,
      appBar: AppBar(
       automaticallyImplyLeading: false,
       titleSpacing: 0,
       toolbarHeight: 44,
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: GestureDetector(
               onTap: (){
                 Get.to(()=>MyPage());
               },
               child: SvgPicture.asset('assets/icon/person.svg')),
         )
       ],
     ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 44),
        child: Column(
          children: [
            Obx(()=> Row(
              children: [
                GestureDetector(
                  onTap: (){
                    ms.selectIdx.value = 0;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ms.selectIdx==0?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('다가오는 여행',style: ms.selectIdx==0?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ms.selectIdx.value = 1;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ms.selectIdx==1?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('지난 여행',style: ms.selectIdx==1?f14Whitew700:f14gray400w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    ms.selectIdx.value = 2;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ms.selectIdx==2?gray900:gray200,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      child: Text('북마크',style: ms.selectIdx==2?f14Whitew700:f14gray400w700),
                    ),
                  ),
                )
              ],
            )),
            // const SizedBox(height: 22),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     SvgPicture.asset('assets/icon/swap.svg'),
            //     const SizedBox(width: 4),
            //     Text('최신순',style: f12gray600w600,),
            //   ],
            // ),
            const SizedBox(height: 32),
            Obx(()=>ms.selectIdx.value==0
                ? CommingTrip()
                : ms.selectIdx.value ==1
                ?  PastTrip()
                :  BookMark()),
            const SizedBox(height: 10,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    InviteDialog(context, 'dasdas', () {
                      Get.back();
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: gray700,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: SvgPicture.asset('assets/icon/chain.svg'
                      ,fit: BoxFit.none,
                       colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>TripRoomAddScreen());
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: gray900,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(child: Text('새 여행방 생성',style: f16Whitew700,)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  final int index;
  const ListItems({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ms = Get.put(MainState());
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: ms.tripList[index]['tripMemberDtoList'].length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, idx){
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: ms.tripList[index]['tripMemberDtoList'][idx]['profileImg']==''?'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media':'${ms.tripList[index]['tripMemberDtoList'][idx]['profileImg']}',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill
                              ),
                            ),
                          ),
                          // placeholder: (context, url) => const CircularProgressIndicator(),
                          // errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(child: Text('${ms.tripList[index]['tripMemberDtoList'][idx]['nickname']}',style: f14Gray800w500,overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              ),
              index==4?SizedBox():Divider(color: gray200,)
            ],
          ),
        );
      },
    );
  }
}
double calculateTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size.width;
}

class TooltipShape extends ShapeBorder {
  const TooltipShape({
    this.borderColor = Colors.black,
    this.borderWidth = 2.0, // 기본 보더 두께를 2로 설정
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)), // 각 모서리에 4의 반경 추가
  });

  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    path.addRRect(
      borderRadius.resolve(textDirection).toRRect(rect).deflate(borderWidth),
    );
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final RRect rrect = borderRadius.resolve(textDirection).toRRect(rect);
    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = borderRadius.resolve(textDirection).toRRect(rect);

    // 화살표 부분을 포함한 경로
    path.moveTo(50 + borderWidth, borderWidth); // 화살표 오른쪽 상단에서 시작
    path.lineTo(40 + borderWidth, -10); // 화살표의 뾰족한 부분
    path.lineTo(30 + borderWidth, borderWidth); // 화살표 왼쪽 상단
    path.lineTo(borderWidth + 10, borderWidth); // 화살표 왼쪽 상단

    // 왼쪽 상단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(borderWidth, borderWidth, borderWidth, 4 + borderWidth);

    // 왼쪽 세로 직선
    path.lineTo(borderWidth, rrect.height - 4 - borderWidth);

    // 왼쪽 하단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(borderWidth, rrect.height - borderWidth, 4 + borderWidth, rrect.height - borderWidth);

    // 하단 직선
    path.lineTo(rrect.width - 4 - borderWidth, rrect.height - borderWidth);

    // 오른쪽 하단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(rrect.width - borderWidth, rrect.height - borderWidth, rrect.width - borderWidth, rrect.height - 4 - borderWidth);

    // 오른쪽 세로 직선
    path.lineTo(rrect.width - borderWidth, 4 + borderWidth);

    // 오른쪽 상단 모서리 곡선 (radius 4로 설정)
    path.quadraticBezierTo(rrect.width - borderWidth, borderWidth, rrect.width - 4 - borderWidth, borderWidth);

    // 상단 직선
    path.lineTo(50 + borderWidth, borderWidth);

    return path;
  }

  @override
  ShapeBorder scale(double t) => TooltipShape(
    borderColor: borderColor,
    borderWidth: borderWidth * t,
    borderRadius: BorderRadius.all(Radius.circular(4.0)), // BorderRadius 스케일링
  );
}

