import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripStory/controller/userState.dart';
import 'package:tripStory/screen/login/register/success.dart';
import '../../../component/bottomContainer.dart';
import '../../../controller/mainState.dart';
import '../../../util/color.dart';
import '../../../util/font.dart';


class ProfilePage extends StatefulWidget {
  final bool marketing;
  const ProfilePage({Key? key, required this.marketing}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  final ms = Get.put(MainState());
  final us = Get.put(UserState());
  TextEditingController nameCon = TextEditingController(); /// 닉네임
  XFile? pickedImage; /// 프로필 이미지
  bool isChecked = false; /// 약관동의 체크
  bool regexCheck = false; /// 주의사항 문구
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: gray200
                    ),
                    child: Center(child: Text('1',style: f12Whitew700,)),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: gray900
                    ),
                    child: Center(child: Text('2',style: f12Whitew700,)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('트립스토리에서',style: f22gray900w700,),
              Text('사용할 프로필을 설정해 주세요',style: f22gray900w700,),
              Text('프로필 사진은 가입 이후에도 설정 가능해요',style: f14Gray700w400,),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: ()async{
                  pickedImage = await ms.getSingleImage(ImageSource.gallery,context,pickedImage);
                  setState(() {});
                },
                child: pickedImage!=null
                    ? Center(
                  child: Container(
                    width: 92,
                    height: 92,
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
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset('assets/icon/plus.svg'))
                      ],
                    ),
                  ),
                )
                    :Center(
                  child: Container(
                    width: 92,
                    height: 92,
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
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset('assets/icon/plus.svg',))

                      ],
                    ),
                  ),),
              ),
              // const SizedBox(height: 32),
              Text('닉네임',style: f12gray600w600,),
              const SizedBox(height: 8,),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: nameCon.text.trim().isEmpty?Border.all(color: gray200):Border.all(color: gray900,width: 1.5),
                    color: gray50
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameCon,
                          autofocus: false,
                          style: f16gray800w600,
                          onChanged: (v){
                            final regex = RegExp(r'^[가-힣a-zA-Z]{1,8}$');
                            if(regex.hasMatch('${nameCon.text}')){
                              isChecked = true;
                              regexCheck = false;
                            }else{
                              isChecked = false;
                            }
                            setState(() {});
                          },
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(8),
                          ],
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: '8자 이내의 한글,영문만 가능해요',
                            hintStyle: f15gray400w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text('${nameCon.text.length}',style: nameCon.text.trim().isEmpty?f11Gray400w600:f11Gray800w600),
                      Text('/8',style: f11Gray400w600,)
                    ],
                  ),
                ),
              ),
              regexCheck?Padding(
                padding: const EdgeInsets.only(left: 16,top: 4),
                child: Text('8자 이내의 한글,영문만 가능해요',style: f11redw500,),
              ):SizedBox(),
              // Container(
              //   width: Get.width,
              //   // height: 64,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: Color(0xffE0E0E0)),
              //       borderRadius: BorderRadius.circular(12)
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left:12,top: 8,),
              //         child: Text('닉네임',style: f14Gray500w400,),
              //       ),
              //       Container(
              //         child: TextFormField(
              //           controller: nameCon,
              //           textAlignVertical: TextAlignVertical.center,
              //           style: f16gray800w600,
              //           decoration: InputDecoration(
              //             isDense: true,
              //             contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              //             border: OutlineInputBorder(
              //               borderSide: BorderSide.none,
              //             ),
              //             hintText: '닉네임을 입력해주세요',
              //             hintStyle: f14Gray500w400,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Spacer(),
              BottomContainer(
                onTap: ()async{
                  if(isChecked==true){
                    if(pickedImage!=null){
                      Map<String, dynamic> url = await us.profileFileUpload(pickedImage!);
                      Map<String, dynamic> thumbnailUrl = await us.profileThumbnailUpload(pickedImage!);
                      await us.userRegister(
                          nameCon.text,
                          '${url['preSignedUrls'][0].toString().split('?')[0]}',
                          '${thumbnailUrl['preSignedUrls'][0].toString().split('?')[0]}',
                          widget.marketing);
                      Get.offAll(()=>SuccessPage());
                    }else{
                      await us.userRegister(nameCon.text, '','',widget.marketing);
                      Get.offAll(()=>SuccessPage());
                    }
                  }else{
                    regexCheck = true;
                    setState(() {});
                  }
                },title: '다음',isBlack: isChecked?true:false),
            ],
          ),
        ),
      ),
    );
  }
}
