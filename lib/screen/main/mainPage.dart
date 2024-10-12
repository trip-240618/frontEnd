import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/app/api/userApi.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/tripState.dart';
import 'package:tripStory/screen/main/tripAdd/tripRoomAdd.dart';
import 'package:tripStory/screen/myPage/myPage.dart';
import '../../app/config/dio_client.dart';
import '../../component/bottomModals.dart';
import '../../component/dialog/loading.dart';
import '../../component/main/emptyScreen.dart';
import '../../util/color.dart';
import '../../util/font.dart';
import '../trip/bottomNavigator.dart';
import 'notification/notification_main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainState ms = Get.put(MainState());
  TripState ts = Get.put(TripState());
  final dioClient = DioClient();
  final apiUserClient = ApiUserClient(DioClient());
  bool isLoading = true;

  void initState() {
    Future.delayed(Duration.zero,()async{
      isLoading = false;
      await ms.getComingTrip();
      setState(() {});
      print('처음 가져오기 ${ms.tripList.length}');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: gray50,
      appBar: AppBar(
        backgroundColor: gray50,
       automaticallyImplyLeading: false,
       titleSpacing: 0,
       toolbarHeight: 44,
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20),
           child: Row(
             children: [
               GestureDetector(
                   onTap: (){
                     Get.to(()=>NotificationMain());
                   },
                   child: SvgPicture.asset('assets/icon/alert.svg')),
               const SizedBox(width: 16,),
               GestureDetector(
                   onTap: (){
                     Get.to(()=>MyPage());
                   },
                   child: SvgPicture.asset('assets/icon/person.svg')),
             ],
           ),
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
                  onTap: ()async{
                    ms.selectIdx.value = 0;
                    setState(() {
                      isLoading = true;
                    });
                    await ms.getComingTrip();
                    setState(() {
                      isLoading = false;
                    });
                    setState(() {});
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
                  onTap: ()async{
                    ms.selectIdx.value = 1;
                    setState(() {
                      isLoading = true;
                    });
                    await ms.getLastTrip();
                    setState(() {
                      isLoading = false;
                    });
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
                  onTap: ()async{
                    ms.selectIdx.value = 2;
                    setState(() {
                      isLoading = true;
                    });
                    await ms.getBookMarkTrip();
                    setState(() {
                      isLoading = false;
                    });
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
            const SizedBox(height: 32),
            isLoading?Expanded(child: LoadingWidget()):Obx(()=>Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: ms.tripList.length==0?1:ms.tripList.length,
                    itemBuilder: (contexts, index) {
                      return ms.tripList.length==0?EmptyScreen(context)
                          :Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 140,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(4)
                            ),
                            child: Stack(
                              children: [
                                SvgPicture.asset('assets/icon/ticket.svg',
                                    width: Get.width,
                                    height:Get.height,
                                    fit: BoxFit.fill),
                                Positioned(
                                    left: 16,
                                    top: 8,
                                    right: 16,
                                    child: Container(
                                      width: Get.width,
                                      child: Row(
                                        children: [
                                          ms.selectIdx.value==1?SvgPicture.asset('assets/icon/calender.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn)):Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(int.parse('${ms.tripList[index]['labelColor']}')),
                                                  width: 1.5, // 1.5px 두께
                                                ),
                                                borderRadius: BorderRadius.circular(100)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                                              child: Text((DateTime.parse('${ms.tripList[index]['startDate']}').difference(DateTime.now()).inDays + 1)<1?'여행중':'D-${DateTime.parse('${ms.tripList[index]['startDate']}').difference(DateTime.now()).inDays + 1}',style: changeColor(Color(int.parse('${ms.tripList[index]['labelColor']}'))),),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text('${ms.tripList[index]['startDate']} ~ ${ms.tripList[index]['endDate']}',style: f12Gray800w500,),
                                          Spacer(),
                                          ms.selectIdx.value==1?const SizedBox():GestureDetector(
                                              onTap: (){
                                                sendBottomModal(context,ms.tripList[index]['invitationCode']);
                                              },
                                              child: SvgPicture.asset('assets/icon/send.svg',color: gray900)),
                                          const SizedBox(width: 12),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () async {
                                              await ms.bookmarkClick(int.parse('${ms.tripList[index]['id']}'));
                                              ms.tripList[index]['bookmark'] = !ms.tripList[index]['bookmark'];
                                              ms.tripList.refresh();
                                            },
                                            child: ms.tripList[index]['bookmark']
                                                ? SvgPicture.asset(
                                              'assets/icon/checkBookmark.svg',
                                            )
                                                : SvgPicture.asset(
                                              'assets/icon/bookmark.svg',
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                Positioned(
                                    top: 40,
                                    child: GestureDetector(
                                      onTap: ()async{
                                        await ts.getSelectTrip(ms.tripList[index]['id']);
                                        Get.to(()=>BottomNavigator());
                                      },
                                      child: Container(
                                        width: Get.width,
                                        height: 120,
                                        color: Colors.transparent,
                                      ),
                                    )
                                ),
                                Positioned(
                                    left: 16,
                                    top: 58,
                                    right: 16,
                                    bottom: 14,
                                    child: Container(
                                      width: Get.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:66,
                                            height: 66,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: CachedNetworkImage(
                                                imageUrl:'${ms.tripList[index]['thumbnail']}',
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
                                          const SizedBox(width: 12),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: Color(int.parse('${ms.tripList[index]['labelColor']}')),
                                                          shape: BoxShape.circle
                                                      ),
                                                      child: Center(child: Text('${ms.tripList[index]['type']}',style: f12Whitew700,))
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text('${ms.tripList[index]['name']}',style: f15gray800w600,)
                                                ],
                                              ),
                                              Spacer(),
                                              Text('${ms.tripList[index]['country']}',style: f12gray600w600,),
                                            ],
                                          ),
                                          Spacer(),
                                          Builder(
                                              builder: (context) {
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:()async{
                                                        int maxlen = await getLongestNicknameLength(ms.tripList[index]['tripMemberDtoList']);
                                                        showPopover(
                                                            context: context,
                                                            bodyBuilder: (context) => ListItems(index: index,),
                                                            direction: PopoverDirection.bottom,
                                                            width: 14*maxlen+100,
                                                            height: 50*ms.tripList[index]['tripMemberDtoList'].length+0,
                                                            contentDyOffset: 10,
                                                            arrowHeight: 8,
                                                            arrowWidth: 13
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: gray200,
                                                            borderRadius: BorderRadius.circular(100)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/icon/userIcon.svg',
                                                              ),
                                                              const SizedBox(width: 5),
                                                              Text('${ms.tripList[index]['tripMemberDtoList'].length}',style: f14gray600w700,)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                          )
                                        ],
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          index==4?SizedBox():SizedBox(height: 12)
                        ],
                      );
                    }),
              ),
            )),
            const SizedBox(height: 10,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    InviteDialog(context,() {
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
      padding: EdgeInsets.zero,
      itemCount: ms.tripList[index]['tripMemberDtoList'].length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, idx){
        return Column(
          children: [
            Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
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
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Expanded(child: Text('${ms.tripList[index]['tripMemberDtoList'][idx]['nickname']}',style: f14Gray800w500,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Divider(color: gray200,height: 5,)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<int> getLongestNicknameLength(List<dynamic> tripMemberDtoList) async{
  int longestLength = 0;

  for (var member in tripMemberDtoList) {
    String nickname = member['nickname'] ?? ''; // null 값 방지를 위해 기본값 '' 처리
    if (nickname.length > longestLength) {
      longestLength = nickname.length;
    }
  }
  return longestLength;
  print('가장 긴 닉네임의 길이: $longestLength');
}
double calculateTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size.width;
}


