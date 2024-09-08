import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:tripStory/app/api/testApi.dart';
import 'package:tripStory/app/api/userApi.dart';
import 'package:tripStory/component/bottomModals.dart';
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
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset('assets/icon/swap.svg'),
                const SizedBox(width: 4),
                Text('최신순',style: f12gray600w600,),
              ],
            ),
            const SizedBox(height: 10),
            // EmptyScreen(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (contexts, index) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=>BottomNavigator());
                        },
                        child: Column(
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
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: greenColor, // #67E299 색상
                                                    width: 1.5, // 1.5px 두께
                                                  ),
                                                  borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                                                child: Text('D-31',style: f14Greenw700,),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text('2024.04.01 ~ 2024.04.07',style: f12Gray800w500,),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: (){
                                                print('??');
                                                sendBottomModal(context);
                                              },
                                                child: SvgPicture.asset('assets/icon/send.svg',color: gray900)),
                                            const SizedBox(width: 12),
                                            SvgPicture.asset('assets/icon/bookmark.svg'),
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
                                                  imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
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
                                                        color: greenColor,
                                                        shape: BoxShape.circle
                                                      ),
                                                      child: Center(child: Text('J',style: f12Whitew700,))
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Text('5월 도쿄 여행방',style: f15gray800w600,)
                                                  ],
                                                ),
                                                Spacer(),
                                                Text('일본',style: f12gray600w600,),
                                              ],
                                            ),
                                            Spacer(),
                                            Builder(
                                              builder: (context) {
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){
                                                        showPopover(
                                                          context: context,
                                                          bodyBuilder: (context) => ListItems(),
                                                          onPop: () => print('Popover was popped!'),
                                                          direction: PopoverDirection.bottom,
                                                          width: 167,
                                                          height: 250,
                                                          contentDyOffset: 10, // Popover를 더 가까이 붙이기
                                                          arrowHeight: 6,
                                                          arrowWidth: 10
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
                                                              Text('5',style: f14gray600w700,)
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
                        ),
                      );
                    }),
              ),
            ),
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
                      color: gray200,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: SvgPicture.asset('assets/icon/chain.svg',fit: BoxFit.none,),
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
                          color: gray500,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(child: Text('새 여행방 생성',style: f16Whitew600,)),
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
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: 5,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index){
        return Container(
          width: 167,
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
                          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
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
                    Text('허지우',style: f14Gray800w500,),
                  ],
                ),
              ),
              index==4?SizedBox():Divider()
            ],
          ),
        );
      },
    );
  }
}