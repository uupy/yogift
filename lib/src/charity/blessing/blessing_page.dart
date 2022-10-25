import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/greeting_card/greeting_card.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/order/order_create_remark.dart';

import 'blessing_controller.dart';
import 'wisgets/detail_info.dart';
import 'wisgets/footer.dart';
import 'wisgets/purchase_step_bar.dart';

class CharityBlessingPage extends StatefulWidget {
  const CharityBlessingPage({Key? key}) : super(key: key);

  @override
  _CharityBlessingPageState createState() => _CharityBlessingPageState();
}

class _CharityBlessingPageState extends State<CharityBlessingPage> {
  final controller = Get.put(CharityBlessingController());
  final purchaseController = Get.put(PurchaseController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('填寫心意卡'),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        // physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const HeaderBackground(),
                const ProgressStepBar(),
                Padding(
                  padding: EdgeInsets.only(top: 70.w),
                  child: const DetailInfo(),
                ),
              ],
            ),
            SizedBox(height: 20.w),
            GreetingCard(
              type: 0,
              onChanged: (id, msg, imageUrl) {
                controller.addForm.bgGive = id;
                controller.addForm.msgGive = msg;
                controller.cardImageUrl = imageUrl;
              },
            ),

            ///優惠券
            GetBuilder<CharityBlessingController>(
              id: 'useCouponController2',
              builder: (c) {
                if (c.isLogged) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    child: GetBuilder<CharityBlessingController>(
                      init: CharityBlessingController(),
                      builder: (c) => AppCard(
                        onTap: () => {
                          Get.toNamed('/pages/goods/purchase/choose_coupon',
                              arguments: {
                                'giftid': c.detail?.id,
                                'skuid': c.detail?.skuId,
                                'n': c.orderInfo?.nums ?? 1,
                                'for_charity': '0'
                              })?.then((value) => {c.updateCouponInfo(value)})
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('使用優惠券'),
                            Row(
                              children: [
                                Text(
                                  c.couponText,
                                  style: TextStyle(
                                      color: c.couponText == "未選擇"
                                          ? const Color.fromRGBO(
                                              163, 163, 163, 1)
                                          : const Color.fromRGBO(
                                              255, 64, 0, 1)),
                                ),
                                Icon(
                                  IconFont.icon_arrow_right,
                                  size: 12.sp,
                                  color: const Color.fromRGBO(163, 163, 163, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),

            OrderRemark(
              onChanged: (value) {
                controller.addForm.content2 = value;
              },
            ),
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: BlessingFooter(
        onTap: () {
          controller.onSubmit();
        },
      ),
    );
  }
}
