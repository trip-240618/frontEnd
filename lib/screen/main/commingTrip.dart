import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/screen/trip/bottomNavigator.dart';
import '../../component/bottomModals.dart';
import '../../component/main/emptyScreen.dart';
import '../../util/color.dart';
import '../../util/font.dart';
import 'mainPage.dart';

class CommingTrip extends StatefulWidget {
  const CommingTrip({super.key});

  @override
  State<CommingTrip> createState() => _CommingTripState();
}

class _CommingTripState extends State<CommingTrip> {
  final ms = Get.put(MainState());
  bool isLoading = true;
  int maxLength = 0;
  @override
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
    return isLoading?Expanded(child: LoadingWidget()):Obx(()=>Expanded(
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
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>BottomNavigator());
                    },
                    child: Container(
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
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(int.parse('${ms.tripList[index]['labelColor']}')),
                                            width: 1.5, // 1.5px 두께
                                          ),
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                                        child: Text('D-${DateTime.parse('${ms.tripList[index]['startDate']}').difference(DateTime.now()).inDays + 1}',style: changeColor(Color(int.parse('${ms.tripList[index]['labelColor']}'))),),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text('${ms.tripList[index]['startDate']} ~ ${ms.tripList[index]['endDate']}',style: f12Gray800w500,),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: (){
                                          print('??');
                                          sendBottomModal(context);
                                        },
                                        child: SvgPicture.asset('assets/icon/send.svg',color: gray900)),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: (){
                                        print('3132');
                                      },
                                        child: ms.tripList[index]['bookmark']?SvgPicture.asset('assets/icon/checkBookmark.svg'):SvgPicture.asset('assets/icon/bookmark.svg')),
                                  ],
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
                                              // PopupMenuButton(
                                              //   offset: Offset(1, 50),
                                              //   shape: const TooltipShape(borderColor: Colors.red,borderWidth: 1),
                                              //   menuPadding: EdgeInsets.only(left: 20,right: 20),
                                              //   itemBuilder: (_) => <PopupMenuEntry>[
                                              //     PopupMenuItem(
                                              //         enabled: false,
                                              //         padding:EdgeInsets.only(left: 10),
                                              //         child: Text('31231ㅇㄴㅁㅇㅁㄴㅇㅁㅇㅁㅇㅁㄴㅇㄴㅁㅇㅁㄴdasdasdasdasdasdasdasdasdasdasda',style: TextStyle(color: Colors.red))
                                              //     ),
                                              //
                                              //   ],
                                              // ),
                                              GestureDetector(
                                                onTap:()async{
                                                 int maxlen = await getLongestNicknameLength(ms.tripList[index]['tripMemberDtoList']);
                                                  showPopover(
                                                      context: context,
                                                      bodyBuilder: (context) => ListItems(index: index,),
                                                      onPop: () => print('Popover was popped!'),
                                                      direction: PopoverDirection.bottom,
                                                      width: 14*maxlen+100,
                                                      height: 30*maxlen+0,
                                                      contentDyOffset: 10, // Popover를 더 가까이 붙이기
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
                  ),
                  index==4?SizedBox():SizedBox(height: 12)
                ],
              );
            }),
      ),
    ));
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
}
