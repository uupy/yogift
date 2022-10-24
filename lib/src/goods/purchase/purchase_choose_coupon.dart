import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift_coupon_item.dart';
import 'package:yo_gift/src/goods/purchase/gift_coupon_controller.dart';
import 'package:yo_gift/src/user/coupon/coupon_item_card.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/header_background.dart';

/// 使用優惠券
class PurchaseChooseCoupon extends StatefulWidget {
  const PurchaseChooseCoupon({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<PurchaseChooseCoupon>
    with TickerProviderStateMixin {
  final controller = Get.put(GiftCouponController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftCouponController>(builder: (c) {
      return Scaffold(
          appBar: AppBar(
              title: const Text('使用優惠券'),
              bottom: TabBar(
                indicatorPadding: EdgeInsets.fromLTRB(35.w, 0, 35.w, 0),
                indicator: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                )),
                controller: _tabController,
                indicatorColor: const Color.fromRGBO(0, 0, 0, 0.9),
                labelColor: const Color.fromRGBO(0, 0, 0, 0.9),
                labelStyle:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                tabs: <Widget>[
                  Tab(
                    text: '可用優惠券(${controller.availiableCount})',
                  ),
                  Tab(
                    text: '不可用優惠券(${controller.disbleCount})',
                  ),
                ],
                onTap: (i) => {controller.updateGiftCouponList(i)},
              )),
          body: Stack(
            children: [
              HeaderBackground(
                height: 165.w,
                radius: 100.w,
              ),
              // GetBuilder<GiftCouponController>(builder: (c) {
              AppListView<GiftCouponItem>(
                fetch: c.queryGiftCouponList,
                controller: c.listController,
                colCount: 1,
                hasPage: false,
                emptyPadding: EdgeInsets.fromLTRB(50.w, 160.w, 50.w, 0),
                padding: EdgeInsets.symmetric(vertical: 12.w),
                itemBuilder: (item, index, list) {
                  return GestureDetector(
                      onTap: () {
                        if (c.state == 1) {
                          Get.back(result: item);
                        }
                      },
                      child: CouponItemCard(
                        item: item,
                      ));
                },
              )
              // }),
            ],
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(30.w),
            child: AppButton(
              onPressed: () {
                Get.back(result: null);
              },
              backgroundColor: const Color.fromRGBO(255, 225, 0, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '不使用優惠券',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
