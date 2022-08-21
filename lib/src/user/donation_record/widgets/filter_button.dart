import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/order/constants.dart';
import 'package:yo_gift/widgets/animated_button.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_radio.dart';

import '../donation_record_controller.dart';

class OrderListFilterButton extends StatelessWidget {
  final Function(int value)? onChanged;

  const OrderListFilterButton({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationRecordController>(
      id: 'OrderListFilterButton',
      builder: (c) {
        return AnimatedButton(
          onPressed: () {
            SmartDialog.showAttach(
              targetContext: context,
              maskWidget: Container(
                width: Get.width,
                margin: EdgeInsets.only(top: Get.statusBarHeight + 40.w),
                color: const Color.fromRGBO(0, 0, 0, 0.3),
              ),
              bindPage: true,
              useSystem: true,
              onDismiss: () {},
              builder: (context) {
                return Container(
                  width: Get.width,
                  margin: EdgeInsets.only(top: 10.w),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.w),
                      bottomLeft: Radius.circular(20.w),
                    ),
                  ),
                  child: AppRadioGroup(
                    onChanged: (value, index) {
                      c.onReload();
                      SmartDialog.dismiss();
                    },
                    items: OrderStatus.items.map((e) {
                      return AppRadio(label: e.label, value: e.value);
                    }).toList(),
                  ),
                );
              },
            );
          },
          color: Colors.white,
          borderColor: Colors.white,
          width: 78.w,
          height: 30.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAssetImage(
                width: 16.w,
                margin: EdgeInsets.only(right: 4.w),
                img: 'icon_filter.png',
              ),
              Text(
                '篩選',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.9),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
