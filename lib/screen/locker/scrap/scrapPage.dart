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
