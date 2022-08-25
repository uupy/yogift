import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods/goods_item.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'pay_result_controller.dart';
import 'widgets/result_card.dart';

class PayResultPage extends StatefulWidget {
  const PayResultPage({Key? key}) : super(key: key);

  @override
  _PayResultPageState createState() => _PayResultPageState();
}

class _PayResultPageState extends State<PayResultPage> {
  final controller = Get.put(PayResultController());

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Container()),
      body: Stack(
        children: [
          HeaderBackground(
            height: 160.w,
            radius: 100.w,
          ),
          AppListView<GiftVo>(
            emptyPadding: EdgeInsets.fromLTRB(50.w, 100.w, 50.w, 0),
            waterDropColor: const Color.fromRGBO(0, 0, 0, 0.26),
            fetch: controller.queryList,
            colCount: 2,
            prefix: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
              child: Column(
                children: [
                  const ResultCard(),
                  Text(
                    '「贈人玫瑰，手有餘香」',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 14.w),
                ],
              ),
            ),
            itemsBuilder: (items, index, list) {
              return Container(
                height: 308.w,
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    ...items.map((item) {
                      return Expanded(
                        child: GoodsItem(
                          margin: EdgeInsets.all(6.w),
                          guid: item.gGuid,
                          name: item.giftName,
                          desc: item.bussinessName,
                          coverImg: item.cCoverImg,
                          buyPrice: item.buyPrice,
                          originalPrice: item.originalPrice,
                          buy1Get1Free: item.buy1Get1FREE,
                          sendingMethod: item.sendingMethod,
                          favorite: item.favorite,
                        ),
                      );
                    }).toList(),
                    if (items.length == 1) Expanded(child: Container()),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
