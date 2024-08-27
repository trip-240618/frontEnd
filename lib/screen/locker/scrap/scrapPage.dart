import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/button.dart';
import 'package:tripStory/screen/locker/scrap/addScrapPage.dart';

import '../../../component/cachedImage.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';

class ScrapPage extends StatefulWidget {
  const ScrapPage({super.key});

  @override
  State<ScrapPage> createState() => _ScrapPageState();
}

class _ScrapPageState extends State<ScrapPage> {
  List scrapList = [{'title':'여행 맛집 리스트', 'content':'도쿄 여행 맛집 리스트 1. 츠케멘 2. 소바','nickname':'김여행'},{'title':'여행 예상 경비 정리', 'content':'texttexttexttexttexttexttexttext','nickname':'나들이'}];
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
                            '도쿄 여행방',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: gray200, width: 1)
                            ),
                            height: 69,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(scrapList[index]['title'],style: f12gray600W700,),
                                      Spacer(),
                                      CircleImage(
                                        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
                                        size: 20,
                                        onTap: (){},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(scrapList[index]['content'],
                                      style: f12gray400w500,
                                      overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4,)
                      ],
                    );
              }),
            )
          ],
        ),
      ),
      floatingActionButton: PlusFloatingButton(
        backgroundColor: gray600,
        onPressed: ()  {
          Get.to(()=>AddScrapPage());
        },)
    );
  }
}
