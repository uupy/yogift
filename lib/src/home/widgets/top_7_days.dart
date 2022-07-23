import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/home/home_controller.dart';
import 'package:yo_gift/widgets/goods_item.dart';
import 'package:yo_gift/widgets/module_title.dart';

class HomeTop7Days extends StatelessWidget {
  const HomeTop7Days({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'top13Wrapper',
      builder: (c) {
        if (c.top7DaysList.isEmpty) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModuleTitle(
              textCn: '7天人氣排行榜',
              textEn: 'RANK',
              suffixAssetImg: 'icon_label_1.png',
            ),
            SizedBox(
              height: 316.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: c.top7DaysList.length,
                itemBuilder: (context, index) {
                  final item = c.top7DaysList[index];
                  return GoodsItem(
                    width: 182.w,
                    topIndex: index + 1,
                    name: item.giftName,
                    desc: item.bussinessName,
                    coverImg: item.cCoverImg,
                    buyPrice: item.buyPrice,
                    originalPrice: item.originalPrice,
                    buy1Get1Free: item.buy1Get1FREE,
                    sendingMethod: item.sendingMethod,
                    margin: index == 0
                        ? EdgeInsets.fromLTRB(20.w, 0, 6.w, 0)
                        : (index == c.top7DaysList.length - 1
                            ? EdgeInsets.fromLTRB(6.w, 0, 20.w, 0)
                            : EdgeInsets.symmetric(horizontal: 6.w)),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
