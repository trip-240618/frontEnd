import 'package:flutter/material.dart';

class SettingNotiPage extends StatefulWidget {
  const SettingNotiPage({super.key});

  @override
  State<SettingNotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<SettingNotiPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // searchHistoryList.isEmpty?Container():Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12),
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Text('검색 기록', style: f12gray900w700,),
        //           Spacer(),
        //           Text('전체 삭제', style: f12gray400W700,),
        //         ],
        //       ),
        //       const SizedBox(height: 16,),
        //       ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: searchHistoryList.length,
        //           itemBuilder: (context, index){
        //             return Padding(
        //               padding: const EdgeInsets.only(bottom: 16),
        //               child: Row(
        //                 children: [
        //                   Text(searchHistoryList[index], style: f14Gray800w500,),
        //                   Spacer(),
        //                   GestureDetector(
        //                       onTap: (){
        //                         searchHistoryList.removeAt(index);
        //                         setState(() {
        //
        //                         });
        //                       },
        //                       child: SvgPicture.asset('assets/icon/close.svg')),
        //                 ],
        //               ),
        //             );
        //           }),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
