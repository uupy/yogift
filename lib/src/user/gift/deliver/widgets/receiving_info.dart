import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';

import '../deliver_controller.dart';

class ReceivingInfo extends StatelessWidget {
  const ReceivingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftDeliverController>(
      id: 'ReceivingInfo',
      builder: (c) {
        final info = c.detail;
        final address = info?.receivingaddressAddress ?? '';
        final area0 = info?.receivingaddressArea0 ?? '';
        final area1 = info?.receivingaddressArea1 ?? '';
        final name = info?.receivingaddressContact ?? '';
        final phone = info?.receivingaddressPhone ?? '';
        bool isEmpty =
            address.isEmpty && area0.isEmpty && name.isEmpty && phone.isEmpty;

        return AppCard(
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
              if (isEmpty)
                Text(
                  '請填寫你的收件地址和聯繫方式',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.26),
                  ),
                ),
              if (!isEmpty)
                Text(
                  '$area0$area1$address $name $phone',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
