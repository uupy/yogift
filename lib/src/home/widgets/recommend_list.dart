import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/home/home_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_radio.dart';
import 'package:yo_gift/widgets/app_tag.dart';
import 'package:yo_gift/widgets/module_title.dart';

import 'recommend_item.dart';

class HomeRecommendList extends StatelessWidget {
  const HomeRecommendList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'recommendWrapper',
      builder: (c) {
        if (c.recommendTitles.isEmpty) {
          return Container();
        }
        return Column(
          children: [
            const ModuleTitle(
              textCn: '推薦禮物',
              textEn: 'RECOMMEND',
              suffixAssetImg: 'icon_label_3.png',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: AppRadioGroup(
                onChanged: (value, index) {
                  c.onRecommendTitleChanged(value);
                },
                cancelAble: true,
                value: c.currentRecommendTitle,
                items: c.recommendTitles.map((e) {
                  return AppRadio(
                    value: e.title,
                    label: '#${e.title}',
                    builder: (selected) {
                      return AppTag(
                        text: '#${e.title}',
                        showShape: selected,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.w),
            ...c.recommendGiftList.map((e) {
              return RecommendItem(
                guid: e.gGuid,
                name: e.giftName,
                desc: e.bussinessName,
                coverImg: e.cCoverImg,
                buyPrice: e.buyPrice,
                buy1Get1Free: e.buy1Get1FREE,
                sendingMethod: e.sendingMethod,
                tag: e.keywords,
              );
            }).toList(),
            Container(
              width: 120.w,
              margin: EdgeInsets.only(bottom: 15.w, top: 20.w),
              child: AppButton(
                backgroundColor: const Color(0xfffffdeb),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '查看所有',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.9),
                      ),
                    ),
                    AppAssetImage(
                      width: 10.w,
                      margin: EdgeInsets.only(left: 4.w),
                      img: 'icon_arrow_right2.png',
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
