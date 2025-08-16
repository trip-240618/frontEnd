import 'package:flutter/material.dart';
import 'package:tripStory/presentation/common/image/cached_image.dart';

class PlanBView extends StatefulWidget {
  const PlanBView({super.key});

  @override
  State<PlanBView> createState() => _PlanBViewState();
}

class _PlanBViewState extends State<PlanBView> {
  @override
  Widget build(BuildContext context) {
    // 중복 제거 + 정리한 URL 목록
    final urls = <String>{
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/31744281/0.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/31744281/4.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/yoojung_sikdang/Yujungsikdang_12.jpg-boSN0xXpn3.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/yoojung_sikdang/Yujungsikdang_13.jpg-L_rYKIGJtD.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/yoojung_sikdang/Yujungsikdang_14.jpg-LYCMC8r6pK.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/31744281/5.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/31744281/2.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/31744281/3.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/31744281/1.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/4.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/5.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/6.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/2.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/3.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/1.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/895457986/0.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/36802965/0.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/36802965/1.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/36802965/4.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/36802965/2.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/ff/attr_img/36802965/3.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_7.jpeg-osBOZDRwkm.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_1.jpeg-ZvPFSFm7K8.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_2.jpeg-ERLA1tsLei.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_3.jpeg-704XNEYB7D.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_4.jpeg-67Sy5mGBaW.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_5.jpeg-AA5Tk3qfEX.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hwaryeonsan_resort/hwayeonsanjang_6.jpeg-rxnb7BC2kv.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_4.jpeg-GLNeWz_Xag.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_2.jpeg-Tvs2KpgAjY.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_1.jpeg-6mG8enO6az.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_3.jpeg-HZQ1MH2aRN.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_7.jpeg-v1WcKrViUV.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_5.jpeg-5DrB9jDTbm.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/dosan_jokbal_%26_kalguksu/Dosan%20Jokbal_6.jpeg-WzPQVKwitd.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/user/25e3cf5cbdec553bc8572ef470bae6e7dc2226da0b9f42e72c25bbd5c0e211d0/profile-image-apne7WD0D2.png",
      "https://artistravel-s3.s3.amazonaws.com/artist/bts/bts-time-2%20%C3%A1%C2%84%C2%87%C3%A1%C2%85%C2%A9%C3%A1%C2%86%C2%A8%C3%A1%C2%84%C2%89%C3%A1%C2%85%C2%A1%C3%A1%C2%84%C2%87%C3%A1%C2%85%C2%A9%C3%A1%C2%86%C2%AB.png-EbVizDrKZ3.png",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/4/event_img/splash_img.png",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/4/event_img/loading_img.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/4/event_img/main_imgv3.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/4/event_img/logo_img.png",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/9/event_img/splash_img.png",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/9/event_img/loading_img.png",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/miniapp/9/event_img/main_img.png",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli3.jpg-JVFiEfyJRw.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli2.jpg-SI5SJs2jeq.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli1.jpg-0e6dlaNLBR.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli4.jpg-ebaEbiJbTi.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli5.jpg-3ExsN5hbPi.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli6.jpg-INKtNNqZ1n.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/gianis_napoli/GianisNapoli7.jpg-BvWOn3Pp_7.jpg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_11.jpeg-VXQLDXVHND.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_1.jpeg-W8dnYA26vu.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_12.jpeg-zdh4mVqcD2.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_8.jpeg-RoOj12hxqK.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_5.jpeg-XNnICP3Vhr.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_2.jpeg-F33s5nOtIp.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_3.jpeg-Jpo41ohLy2.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_4.jpeg-Ojf_gy9Rnn.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_9.jpeg-y_387uOWaf.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_6.jpeg-yCKBJWMBcs.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_7.jpeg-Cm80JU11bv.jpeg",
      "https://artistravel-s3.s3.us-east-2.amazonaws.com/attraction/hotel_cappuccino/Hotel%20Cappuccino_10.jpeg-SLvhumau5o.jpeg"
    }.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('이미지 리스트')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedImage(imageUrl: urls[index], width: 200, height: 200)),
          );
        },
      ),
    );
  }
}
