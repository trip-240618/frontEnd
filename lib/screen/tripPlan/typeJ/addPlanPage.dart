import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripStory/component/appbar.dart';

import '../../../util/color.dart';
import '../../../util/font.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({super.key});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  TextEditingController placeCon = TextEditingController();
  TextEditingController planTitleCon = TextEditingController();
  TextEditingController memoCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {
        });
      },
      child: Scaffold(
        backgroundColor: gray50,
        appBar: BackAppBar(text: '일정 추가', onTap: (){Get.back();}),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 44),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 장소
              Padding(
                padding: const EdgeInsets.only(left: 16,bottom: 4),
                child: Text('장소 입력', style: f14gray400w700,),
              ),
              TextFormField(
                controller: placeCon,
                textAlignVertical: TextAlignVertical.center,
                style: f16gray800w600,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gray200), // 포커스된 상태에서 보더 색상 변경
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              /// 일정
              Padding(
                padding: const EdgeInsets.only(left: 16,bottom: 4),
                child: Text('일정 입력', style: f14gray400w700,),
              ),
              TextFormField(
                controller: planTitleCon,
                textAlignVertical: TextAlignVertical.center,
                style: f16gray800w600,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gray200),
                  ),
                ),
              ),
              const SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.only(left: 16,bottom: 4),
                child: Text('메모', style: f14gray400w700,),
              ),
              TextFormField(
                controller: memoCon,
                textAlignVertical: TextAlignVertical.center,
                style: f16gray800w600,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  contentPadding:EdgeInsets.symmetric(vertical: 15,horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gray200),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(height: 35,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: gray500,
                  ),
                  child: Center(child: Text('저장', style: f16Whitew600,)),
                ),
              )

            ],
          ),
        ),

      ),
    );
  }
}
