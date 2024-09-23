import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/button.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';
import 'addScrapPage.dart';

class ScrapPage extends StatefulWidget {
  const ScrapPage({super.key});

  @override
  State<ScrapPage> createState() => _ScrapPageState();
}

class _ScrapPageState extends State<ScrapPage> {
  List scrapList = [
    {'date':'2024.04.23','title':'고효율 작업을 위한 생산성 도구 추천', 'content':r'[{"insert":"이 제품은 정말 대박이에요!!! 사용하고 나서부터 생활이 편리해졌어요 강추합니다 너무 마음에 들어요!!!!!!!!!!!!!!!!!!!!!! \n"}]','nickname':'김여행', 'color':'0xff5E91EE'},
    {'date':'2024.04.13','title':'돈키호테 쇼핑리스트', 'content':r'[{"insert":"Ddfsdfd\nㅇㅏㄴㄴㅕㅇㅎㅏㅅㅔㅇㅛ\n"}]','nickname':'나들이', 'color':'0xff83CF75'},
    {'date':'2024.04.13','title':'돈키호테 쇼핑리스트2', 'content':r'[{"insert":"1.멜라노CC폼클렌징\n2.하다라보 하쿠쥰\n3. 나츄리에 하또\n4. 퓨어 청포도젤리\n5. 썬스프레이\n"}]','nickname':'나들이', 'color':'0xff83CF75'},
    {'date':'2024.06.33','title':'타이틀 1줄 간격', 'content':r'[{"insert":"dddd1.멜라노CC폼클렌징\n"}]','nickname':'나들이', 'color':'0xffF2685F'},
    {'date':'2024.04.23','title':'공항에서 숙소 가는법', 'content':r'[{"insert":"숙소 위치에서 공항까지 가려면 아사쿠사 역에서 아사쿠사 급행노선을 타고 가야해\n"}]','nickname':'김여행', 'color':'0xff5E91EE'},
    {'date':'2024.04.13','title':'드럭스토어 쇼핑리스트', 'content':r'[{"insert":"ㅇㅇㅇㅇㅇㅇㅇ\n"}]','nickname':'나들이', 'color':'0xffF4DC59'},
    {'date':'2024.04.13','title':'돈키호테 쇼핑리스트', 'content':r'[{"insert":"1.멜라노CC폼클렌징\n2.하다라보 하쿠쥰\n3. 나츄리에 하또어쩌구\n4. 퓨어 청포도젤리\n"}]','nickname':'나들이', 'color':'0xff83CF75'},
    {'date':'2024.06.33','title':'타이틀 1줄 간격', 'content':r'[{"insert":"dddd1.멜라노CC폼클렌징\n"}]','nickname':'나들이', 'color':'0xffFFFFFF'},
    {'date':'2024.04.23','title':'고효율 작업을 위한 생산성 도구 추천', 'content':r'[{"insert":"이 제품은 정말 대박이에요!!! 사용하고 나서부터 생활이 편리해졌어요 강추합니다 너무 마음에 들어요!!!!!!! \n"}]','nickname':'김여행', 'color':'0xff5E91EE'},
    {'date':'2024.04.13','title':'돈키호테 쇼핑리스트', 'content':r'[{"insert":"Ddfsdfd\nㅇㅏㄴㄴㅕㅇㅎㅏㅅㅔㅇㅛ\n"}]','nickname':'나들이', 'color':'0xff83CF75'},
    {'date':'2024.04.13','title':'돈키호테 쇼핑리스트2', 'content':r'[{"insert":"1.멜라노CC폼클렌징\n2.하다라보 하쿠쥰\n3. 나츄리에 하또\n4. 퓨어 청포도젤리\n5. 썬스프레이\n"}]','nickname':'나들이', 'color':'0xff83CF75'},
    {'date':'2024.06.33','title':'타이틀 1줄 간격', 'content':r'[{"insert":"dddd1.멜라노CC폼클렌징\n"}]','nickname':'나들이', 'color':'0xffF2685F'},
    {'date':'2024.04.23','title':'공항에서 숙소 가는법', 'content':r'[{"insert":"숙소 위치에서 공항까지 가려면 아사쿠사 역에서 아사쿠사 급행노선을 타고 가야해\n"}]','nickname':'김여행', 'color':'0xff5E91EE'},

  ];
  @override
  void initState() {
    String test = jsonToString(scrapList[6]['content']);
    print(test);
    super.initState();
  }

  String jsonToString(String jsonData){
    var myJson = jsonDecode(jsonData); /// 디비 연결시 r'data' 식으로 형태 변경 예정
    QuillController _controller = QuillController.basic();
    _controller = QuillController(
      document: Document.fromJson(myJson),
      selection: TextSelection.collapsed(offset: 0),
    );
    String stringText = _controller.document.toPlainText();
    return stringText;
  }

  void jsonD() {
    String data = r'[{"insert":"Ddfsdfd\nㅇㅏㄴㄴㅕㅇㅎㅏㅅㅔㅇㅛ"},{"insert":{"image":"https://trip-story.s3.ap-northeast-2.amazonaws.com/test/6bb5a043-fd6f-4f00-8803-35e7823c3287"}},{"insert":{"image":"https://trip-story.s3.ap-northeast-2.amazonaws.com/test/6bb5a043-fd6f-4f00-8803-35e7823c3287"}},{"insert":"\n"}]';
     var myJson = jsonDecode(data);
    QuillController _controller = QuillController.basic();
    _controller = QuillController(
      document: Document.fromJson(myJson),
      selection: TextSelection.collapsed(offset: 0),
    );
    String plainText = _controller.document.toPlainText();
    print(plainText);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: MasonryGridView.count(
                physics: const ClampingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: scrapList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(
                        color: gray200,
                        width: 1
                      )
                    ),
                    //height: 194*(index/2),
                    constraints: BoxConstraints(
                      maxHeight: 230,
                      minHeight: 133
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: Get.width,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(int.parse(scrapList[index]['color'])),/// 데이터 연결하고 방식 바꿀 예정
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            border: Border(
                              bottom: BorderSide(
                                  color: gray200,
                                  width: 1
                              )
                            )
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.25, horizontal: 3.5),
                                  child: SvgPicture.asset('assets/icon/bookmark.svg', color: gray900,),
                                ),
                                const SizedBox(width: 6,),
                                Text('${scrapList[index]['date']}', style: f11Gray900w400,),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${scrapList[index]['title']}', overflow: TextOverflow.ellipsis,maxLines: 2, style: f14gray800w700,),
                              const SizedBox(height: 4,),
                              Text(jsonToString(scrapList[index]['content']), overflow: TextOverflow.ellipsis,maxLines: 4,  style: f12Gray800w500)
                            ],
                          ),
                        ),
                        Container(
                          height: 34,
                          child: Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            child: Row(
                              children: [
                                Text('${scrapList[index]['nickname']}', style: f11Gray600w400,),
                                Spacer(),
                                SvgPicture.asset('assets/icon/trashCan.svg')

                              ],

                            ),

                          ),
                        )

                      ],
                    ),
                  );
                },
              )
              // child: GridView.custom(
              //   gridDelegate: SliverWovenGridDelegate.count(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 0,
              //     crossAxisSpacing: 16,
              //     pattern: [
              //       WovenGridTile(1),
              //       WovenGridTile(
              //         5 / 7,
              //         alignment: AlignmentDirectional.bottomStart,
              //       ),
              //     ],
              //   ),
              //   childrenDelegate: SliverChildBuilderDelegate(
              //         (context, index) => Container(
              //           color: Colors.grey,
              //           child: Text('${index}'),
              //         )
              //   ),
              // ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: 2,
            //       itemBuilder: (BuildContext context, int index){
            //         return Column(
            //           children: [
            //             GestureDetector(
            //               onTap: (){},
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(4),
            //                   border: Border.all(color: gray200, width: 1)
            //                 ),
            //                 height: 69,
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(12),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Row(
            //                         children: [
            //                           Text(scrapList[index]['title'],style: f12gray600W700,),
            //                           Spacer(),
            //                           CircleImage(
            //                             imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/userImage%2F6sYlEQ7iIBAkqplhqe3E?alt=media',
            //                             size: 20,
            //                             onTap: (){},
            //                           ),
            //                         ],
            //                       ),
            //                       const SizedBox(height: 4,),
            //                       Text(scrapList[index]['content'],
            //                           style: f12gray400w500,
            //                           overflow: TextOverflow.ellipsis,),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(height: 4,)
            //           ],
            //         );
            //   }),
            // )
          ],
        ),
      ),
      floatingActionButton: PlusFloatingButton(
        backgroundColor: gray900,
        onPressed: ()  {
          Get.to(()=>AddScrapPage());
        },)
    );
  }
}
