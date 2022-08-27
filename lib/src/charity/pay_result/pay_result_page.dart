import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/progress_bar.dart';

import 'pay_result_controller.dart';
import 'widgets/footer.dart';
import 'widgets/result_card.dart';

class CharityPayResultPage extends StatefulWidget {
  const CharityPayResultPage({Key? key}) : super(key: key);

  @override
  _CharityPayResultPageState createState() => _CharityPayResultPageState();
}

class _CharityPayResultPageState extends State<CharityPayResultPage> {
  final controller = Get.put(CharityPayResultController());

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssetImage(
              width: 24.w,
              height: 24.w,
              margin: EdgeInsets.only(right: 8.w),
              img: 'icon_logo.png',
            ),
            Text(
              'YO! GIFT有禮物',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff414042),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GetBuilder<CharityPayResultController>(
          builder: (c) {
            final order = c.orderInfo;
            final goods = c.goodsInfo;
            final total = goods?.quantity ?? 0;
            final completed = goods?.quantityGet ?? 0;

            return Column(
              children: [
                Stack(
                  children: [
                    HeaderBackground(
                      height: 160.w,
                      radius: 100.w,
                    ),
                    const ResultCard(),
                  ],
                ),
                AppAssetImage(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  img: 'img_love2.png',
                ),
                AppImage(
                  width: 105.w,
                  height: 105.w,
                  radius: 20.r,
                  margin: EdgeInsets.only(top: 16.w, bottom: 8.w),
                  cropWidth: 200,
                  cropHeight: 200,
                  url: order?.cCoverImg,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                  child: Text(
                    '「${order?.charityName ?? ''}」所需要的「${order?.giftName ?? ''}」數量還剩：',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                ),
                Text(
                  '${total - completed}件',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffff8d00),
                  ),
                ),
                ProgressBar(
                  total: total,
                  completed: completed,
                  margin: EdgeInsets.fromLTRB(20.w, 8.w, 20.w, 20.w),
                ),
                Text(
                  '當數量達到所需數量時，',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: order?.bussinessName ?? '',
                        style: const TextStyle(
                          color: Color(0xffff8d00),
                        ),
                      ),
                      const TextSpan(text: '將自動安排送貨至'),
                      TextSpan(
                        text: order?.charityAddress ?? '',
                        style: const TextStyle(
                          color: Color(0xffff8d00),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 8.w, right: 20.w, bottom: 10.w),
                  child: Text(
                    '最後更新：${goods?.lastOrderCreateTime ?? ''}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.26),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CharityPayResultFooter(
        onTrack: () {
          Get.toNamed('/pages/mine/donation-record/detail/index', parameters: {
            'id': controller.orderId!,
          });
        },
      ),
    );
  }
}
