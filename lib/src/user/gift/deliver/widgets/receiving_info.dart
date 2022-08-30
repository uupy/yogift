import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../deliver_controller.dart';

class ReceivingInfo extends StatelessWidget {
  const ReceivingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftDeliverController>(
      builder: (c) {
        final info = c.detail;
        final orderStatus = info?.orderStatus;
        final address = info?.receivingaddressAddress ?? '';
        final area0 = info?.receivingaddressArea0 ?? '';
        final area1 = info?.receivingaddressArea1 ?? '';
        final name = info?.receivingaddressContact ?? '';
        final phone = info?.receivingaddressPhone ?? '';
        bool isEmpty =
            address.isEmpty && area0.isEmpty && name.isEmpty && phone.isEmpty;

        return AppCard(
          onTap: () {
            if (orderStatus == 1) {
              Get.toNamed('/pages/mine/addr-setting/index');
            }
          },
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '收貨地址和聯繫方式',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 8.w),
              AppSimpleRow(
                expanded: Text(
                  isEmpty
                      ? '請填寫你的收件地址和聯繫方式'
                      : '$area0$area1$address $name $phone',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color.fromRGBO(0, 0, 0, isEmpty ? 0.26 : 0.9),
                  ),
                ),
                suffix: orderStatus == 1
                    ? AppAssetImage(
                        width: 8.w,
                        margin: EdgeInsets.only(left: 16.w),
                        img: 'icon_arrow_right2.png',
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
