import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../component/appbar.dart';
import '../../../util/font.dart';

class SearchHistoryResult extends StatefulWidget {
  const SearchHistoryResult({super.key});

  @override
  State<SearchHistoryResult> createState() => _SearchHistoryResultState();
}

class _SearchHistoryResultState extends State<SearchHistoryResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrailingBackAppBar(text: '사진 검색', backTap: (){Get.back();}, svgPicture: SvgPicture.asset( 'assets/icon/map.svg',fit: BoxFit.none,),trailingTap: (){print('12');},),
      body:
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0, // 열 간의 간격
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.793,
                ),
                itemCount: 10,
                itemBuilder: (context, index){
                  return Container(
                    width: 120,
                    child: Stack(
                      children: [
                        Positioned(
                          child: CachedNetworkImage(
                            //imageUrl: 'https://firebasestorage.googleapis.com/v0/b/circlet-9c202.appspot.com/o/studyImage%2F1EjyruHeHaU6ZQpNe22L?alt=media',
                            imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/foodImage.jpeg?alt=media',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
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
                        Positioned(
                          top:12,
                          right:12,
                          child: Container(
                            width: 20,
                            height: 20,
                            child: CachedNetworkImage(
                              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tripstory-14935.appspot.com/o/profile.png?alt=media',
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Positioned(
                          left:12,
                          bottom:12,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 4,
                            runSpacing: 4,
                            children: ['긴자', '음식'].map((item) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: Color(0xff83CF75),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(child: Text('#', style: f10Whitew700,)),
                                    ),
                                    const SizedBox(width: 2,),
                                    Text(
                                      '${item}',
                                      style: f12whitew500,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(
                            ),
                          ),
                        )
                      ],
                    ),
                  );
              
                }
              ),
            ),


          ],
        ),),

    );
  }
}
