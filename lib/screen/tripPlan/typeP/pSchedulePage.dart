import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tripStory/util/color.dart';
import 'package:tripStory/util/font.dart';
import 'package:get/get.dart';


class PSchedulePage extends StatefulWidget {
  const PSchedulePage({super.key});

  @override
  State<PSchedulePage> createState() => _PSchedulePageState();
}

class _PSchedulePageState extends State<PSchedulePage> {

  DateTime startDay = DateTime(2024, 5, 10);
  DateTime endDay = DateTime(2024, 5, 14);
  final DateFormat dayFormatter = DateFormat('M월/d일(E)', 'ko');
  final DateFormat formatter = DateFormat('yyyy.MM.dd', 'ko_KR');
  int dayCnt = 0;
  int cnt = 0;
  List dates = [];
  List scheduleList = [
    {'date':'5월/10일(금)','content':'항공편 KE371 도쿄행 인천 출발1', 'checked':true},
    {'date':'5월/10일(금)','content':'항공편 KE371 도쿄행 인천 출발2', 'checked':false},
    {'date':'5월/10일(금)','content':'항공편 KE371 도쿄행 인천 출발3', 'checked':true},
    {'date':'5월/10일(금)','content':'항공편 KE371 도쿄행 인천 출발4', 'checked':true},
    {'date':'5월/10일(금)','content':'항공편 KE371 도쿄행 인천 출발5', 'checked':true},
    {'date':'5월/11일(토)','content':'항공편 KE371 도쿄행 인천 출발6', 'checked':false},
    {'date':'5월/12일(일)','content':'항공편 KE371 도쿄행 인천 출발7', 'checked':false},
    {'date':'5월/13일(월)','content':'항공편 KE371 도쿄행 인천 출발8', 'checked':false},];
  List value = ['5월/10일(금)','5월/11일(토)','5월/12일(일)','5월/13일(월)'];

  @override
  void initState() {
    dayCnt = endDay.difference(startDay).inDays;
    print(dayCnt);
    print('포메터 테스트 ${DateFormat('M월/d일(E)', 'ko').format(startDay)}');

    print('${DateFormat('M월/d일(E)','ko').format(startDay.add(Duration(days: 1)))}'=='5월/11일(토)');
    print('5월/10(금)');
    '5월/10(금)' == '${dayFormatter.format(startDay)}'?print('같음----${dayFormatter.format(startDay)}'):print('다음----${dayFormatter.format(startDay)}');
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        title: Text('5월 도쿄 여행방'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('${formatter.format(startDay)}~${formatter.format(endDay)}',style: f12gray400w500)),
            const SizedBox(height: 8,),
            ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: scheduleList.length,
              buildDefaultDragHandles: false,
              itemBuilder: (BuildContext context, int index) {
                //final itemKey = Key('${scheduleList[index]['index']}');
                return Column(
                  key: Key('${index}'),
                  children: [
                    const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  scheduleList[index]['checked'] = !scheduleList[index]['checked'];
                                  setState(() {

                                  });
                                },
                                child: SvgPicture.asset(
                                  scheduleList[index]['checked']
                                      ? 'assets/icon/checked.svg'
                                      : 'assets/icon/unchecked.svg',
                                ),
                              ),
                              const SizedBox(width: 12,),
                              Text('${scheduleList[index]['content']}',style: f14Gray400w500,),
                              Spacer(),
                              GestureDetector(
                                child: ReorderableDragStartListener(
                                  index: index,
                                  child: Container(
                                    width: 20,
                                      child: SvgPicture.asset('assets/icon/ellipsis.svg')),

                                ),
                              ),
                            ],
                          ),
                        )
                  ],
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if(oldIndex<newIndex){
                    newIndex -= 1;
                  }
                  var element = scheduleList.removeAt(oldIndex);
                  scheduleList.insert(newIndex,element);

                });
              },

            ),
          ],
        ),
      ),
    );
  }
}
