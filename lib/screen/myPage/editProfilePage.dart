import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/component/appbar.dart';
import 'package:tripStory/component/dialog/dialog.dart';
import 'package:tripStory/component/dialog/loading.dart';
import 'package:tripStory/component/textForm/textform.dart';
import 'package:tripStory/controller/mainState.dart';
import 'package:tripStory/controller/userState.dart';
import '../../component/bottomContainer.dart';
import '../../component/empty/emptyScreen.dart';
import '../../util/color.dart';
import '../../util/font.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final us = Get.put(UserState());
  final ms = Get.put(MainState());
  final TextEditingController _nickCon = TextEditingController();
  final TextEditingController _memoCon = TextEditingController();
  ScrollController scrollController = ScrollController();
  XFile? pickedImage;
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      print('us?? ${us.userList[0]}');
      _nickCon.text = us.userList[0]['name'];
      _memoCon.text = us.userList[0]['memo'];
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _nickCon.dispose();
    _memoCon.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackAppBar(text: '프로필',onTap: (){Get.back();},color: Colors.white,),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 38,bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: ()async{
                    pickedImage = await ms.getSingleImage(ImageSource.gallery,context,pickedImage);
                    setState(() {});
                  },
                  child: pickedImage==null&&(us.userList[0]['thumbnail']!=''&&us.userList[0]['thumbnail']!=null)?
                  Center(
                    child: Container(
                      width: 98,
                      height: 98,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: us.userList[0]['thumbnail']==''?DefaultProfileScreen(context):CachedNetworkImage(
                              imageUrl: us.userList[0]['thumbnail'],
                              width: 80,
                              height: 80,
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
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: Color(0xffECECEC))
                              ),
                              child: SvgPicture.asset('assets/icon/photo.svg',fit: BoxFit.none,colorFilter: ColorFilter.mode(gray500,BlendMode.srcIn)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ) : pickedImage!=null
                      ? Center(
                    child: Container(
                      width: 98,
                      height: 98,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(pickedImage!.path),
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: Color(0xffECECEC))
                              ),
                              child: SvgPicture.asset('assets/icon/photo.svg',fit: BoxFit.none,colorFilter: ColorFilter.mode(gray500,BlendMode.srcIn)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                      : Center(
                    child: Container(
                      width: 98,
                      height: 98,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFEEEEEE), // 색상 코드 #EEEEEE를 Flutter의 Color로 변환
                                    width: 1.0, // border의 두께 (1px)
                                  ),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Center(child: SvgPicture.asset('assets/icon/image.svg',width: 28)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: Color(0xffECECEC))
                              ),
                              child: SvgPicture.asset('assets/icon/photo.svg',fit: BoxFit.none,colorFilter: ColorFilter.mode(gray500,BlendMode.srcIn)),
                            ),
                          )
                        ],
                      ),
                    ),),
                ),
                const SizedBox(height: 47),
                Text('닉네임',style: f12gray700W700,),
                const SizedBox(height: 10),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: gray50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: gray200)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormFieldComponent(
                              controller: _nickCon,
                              hintText: '닉네임을 입력해주세요',
                              onChanged: (v){setState(() {});},
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(8),
                              ],
                          )
                        ),
                        const SizedBox(width: 10,),
                        Text('${_nickCon.text.length}',style: f11Gray800w600,),
                        Text('/8',style: f11Gray400w600,)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text('자기소개', style: f12gray600w600,),
                const SizedBox(height: 8,),
                Container(
                  width: Get.width,
                  height: 76,
                  decoration: BoxDecoration(
                    color: gray50,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: gray200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextMemoFormFields(
                              controller: _memoCon,
                              hintText: '자기소개를 작성해 주세요',
                              textInputType: TextInputType.text,
                              onChanged: (v){setState(() {});},
                              inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(16),
                                ],
                            )),
                        //   TextFormField(
                        //     onChanged: (con){
                        //       setState(() {});
                        //     },
                        //     scrollPadding: EdgeInsets.only(
                        //         bottom: MediaQuery.of(context).viewInsets.bottom + 40),
                        //     decoration: InputDecoration(
                        //       isDense: true,
                        //       contentPadding: EdgeInsets.zero,
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       hintText: '자기소개를 작성해 주세요',
                        //       hintStyle: f15gray400w500,
                        //     ),
                        //     keyboardType: TextInputType.multiline,
                        //     maxLines: null,
                        //     controller: _memoCon,
                        //     style: f16gray800w600,
                        //     inputFormatters: <TextInputFormatter>[
                        //       LengthLimitingTextInputFormatter(16),
                        //     ],
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('${_memoCon.text.length}', style: _memoCon.text.length>0?f11Gray800w600:f11Gray400w600,),
                            Text('/16 ', style: f11Gray400w600,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom/2),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 42),
          child: BottomContainer(
              onTap: ()async{
                showConfirmCancelTapDialog(context, '프로필을 수정하시겠습니까?', '확인', null, ()async{
                  if(pickedImage!=null){
                    Map<String, dynamic> url = await us.profileFileUpload(pickedImage!);
                    Map<String, dynamic> thumbnailUrl = await us.profileThumbnailUpload(pickedImage!);
                    await us.userModify(
                        _nickCon.text,
                        _memoCon.text,
                        '${thumbnailUrl['preSignedUrls'][0].toString().split('?')[0]}',
                        '${url['preSignedUrls'][0].toString().split('?')[0]}');
                  }else{
                    await us.userModify(
                        _nickCon.text,
                        _memoCon.text,
                        '${us.userList[0]['thumbnail']}',
                        '${us.userList[0]['profileImg']}');
                  }
                  Get.back();
                });
              },title: '저장하기',isBlack: true),
        ),
      ),
    );
  }
}
