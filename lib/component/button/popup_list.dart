import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/mainState.dart';
import '../../util/color.dart';
import '../../util/font.dart';
import '../empty/emptyScreen.dart';

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
                                errorWidget: (context, url, error) => DefaultProfileScreen(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
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