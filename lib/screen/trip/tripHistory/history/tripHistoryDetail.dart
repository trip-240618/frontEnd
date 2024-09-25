import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import '../../../../controller/historyState.dart';
import '../../../../util/color.dart';
import '../../../../util/font.dart';
import 'model/detailItem.dart';

class TripHistoryDetailPage extends StatefulWidget {
  const TripHistoryDetailPage({super.key});

  @override
  State<TripHistoryDetailPage> createState() => _TripHistoryDetailPageState();
}

class _TripHistoryDetailPageState extends State<TripHistoryDetailPage>{
  TextEditingController textCon = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final hs = Get.put(HistoryState());

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await hs.addDetailItem();
    });
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                AssetEntityImage(
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.high,
                  thumbnailSize: ThumbnailSize.square(700),
                  thumbnailFormat: ThumbnailFormat.png,
                  hs.selectAlbumList[1],
                  width: Get.width,
                  height: Get.height*0.6,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xff212121).withOpacity(0.5),
                        ],
                        stops: [0.54, 1],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icon/heart.svg',colorFilter: ColorFilter.mode(pastelBlue,BlendMode.srcIn)),
                      const SizedBox(width: 4),
                      Text('4',style: f14Gray800w500,),
                      const SizedBox(width: 8),
                      SvgPicture.asset('assets/icon/chat.svg'),
                      const SizedBox(width: 4),
                      Text('4',style: f14Gray800w500,),
                    ],
                  ),
                  const SizedBox(height: 24,),
                ],
              ),
            ),
            Obx(()=>ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: hs.detailList[0].comments.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, regionIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: 'https://trip-story.s3.ap-northeast-2.amazonaws.com/profile/8564dd09-bbe7-4515-9a7d-7322f4fb5cb6',
                            width: 24,
                            height: 24,
                            fit: BoxFit.fill,
                            // placeholder: (context, url) =>
                            // const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Text('허지우'),
                        const SizedBox(width: 6,),
                        Text('지금'),
                        Spacer(),
                        PopupMenuButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                            ),
                            offset: const Offset(-20, 40),
                            shadowColor: Colors.black.withOpacity(0.4),
                            icon: Container(
                              height: 15,
                              width: 20,
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                'assets/icon/dot.svg',
                                height: 15,
                                width: 20,
                              ),
                            ),
                            color: gray50,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                padding: EdgeInsets.zero,
                                value: 1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                                            const SizedBox(width: 10,),
                                            Text(
                                              '수정하기',
                                              style: f14Gray800w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(color: gray200,), // Divider를 Column 내의 다른 자식으로 이동
                                  ],
                                ),
                                onTap: () {
                                  // 수정하기를 클릭했을 때의 동작
                                },
                              ),
                              PopupMenuItem(
                                  height: 0,
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Center(child: SvgPicture.asset('assets/icon/pencil.svg',colorFilter: ColorFilter.mode(gray600,BlendMode.srcIn))),
                                              const SizedBox(width: 10,),
                                              Text(
                                                '삭제하기',
                                                style: f14Gray800w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              )]),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('이때 너무 좋았는데.. 그립다ㅠ'),
                    const SizedBox(height: 22),
                  ],
                );
              },
            )),
            SizedBox(height: 80),
          ],
        ),
      ),
      bottomSheet: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding:const EdgeInsets.only(
              left: 20, right: 20, top: 10, bottom: 10),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: gray50,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: gray200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textCon,
                    autofocus: false,
                    style: f16gray800w600,
                    onChanged: (v) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: '댓글을 입력해주세요',
                      hintStyle: f14Gray500w400,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: (){
                    hs.addCommentToDetailItem(
                      0,
                      Comment(
                        username: 'user3',
                        content: '댓글 추가하기!',
                        timestamp: DateTime.now(),
                      ),
                    );
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent+100);
                    print('312321');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: gray900,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      child: Text('등록',style: f12Whitew700,),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 30,
        color: Colors.white,
      ),
    );
  }
}
