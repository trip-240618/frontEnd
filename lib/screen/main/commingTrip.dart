import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import '../../component/bottomModals.dart';
import '../../util/color.dart';
import '../../util/font.dart';
import 'mainPage.dart';

class CommingTrip extends StatefulWidget {
  const CommingTrip({super.key});

  @override
  State<CommingTrip> createState() => _CommingTripState();
}

class _CommingTripState extends State<CommingTrip> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (contexts, index) {
              return Column(
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
                                          color: greenColor,
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
                                              onTap:(){
                                                showPopover(
                                                    context: context,
                                                    bodyBuilder: (context) => ListItems(),
                                                    onPop: () => print('Popover was popped!'),
                                                    direction: PopoverDirection.bottom,
                                                    width: 14*5+100,
                                                    height: 250,
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
              );
            }),
      ),
    );
  }
}
