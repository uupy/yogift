import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../purchase_controller.dart';

class DonationCharityInfo extends StatelessWidget {
  const DonationCharityInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'DonationCharityInfo',
      builder: (c) {
        final item = c.orderInfo;

        if (!c.isDonation) {
          return Container();
        }

        return AppCard(
          margin:
              EdgeInsets.only(top: 16.w, left: 20.w, right: 20.w, bottom: 12.w),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              AppSimpleRow(
                expanded: Text(
                  '您將捐贈至以下機構',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
              buildRow('捐贈機構', item?.charityName),
              buildRow('收貨地址', item?.charityAddress),
              buildRow('聯繫電話',
                  '${item?.charityPhonePrefix ?? ''} ${item?.charityPhone ?? ''}'),
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
