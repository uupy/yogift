import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../donation_detail_controller.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationDetailController>(
      id: 'DeliveryInfoCard',
      builder: (c) {
        final item = c.detail;

        return AppCard(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.w),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              AppSimpleRow(
                expanded: Text(
                  '收貨地址和聯繫方式',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
              buildRow('捐贈機構', item?.charityName),
              buildRow('收貨地址', item?.charityAddress),
            ],
          ),
        );
      },
    );
  }

  Widget buildRow(String label, String? content) {
    return AppSimpleRow(
      margin: EdgeInsets.only(top: 12.w),
      expanded: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
          ),
          children: [
            TextSpan(
              text: '$label  ',
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ),
            TextSpan(
              text: content ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
