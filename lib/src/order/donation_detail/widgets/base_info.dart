import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../donation_detail_controller.dart';

class OrderDetailBaseInfo extends StatelessWidget {
  const OrderDetailBaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationDetailController>(
      id: 'OrderDetailBaseInfo',
      builder: (c) {
        final expirationTime = c.detail?.expirationTime ?? '';
        final orderMoney = c.detail?.orderMoney ?? 0;
        final couponCash = c.detail?.ygcoupon1Cash ?? 0;

        return Container(
          margin: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 0),
          child: Column(
            children: [
              buildRow(
                label: '已總付',
                content: '\$${Decimal.parse(orderMoney.toString())}',
              ),
              if (couponCash > 0)
                buildRow(
                  label: '使用優惠券',
                  content: '- \$$couponCash',
                  contentColor: const Color(0xffff3b30),
                ),
              buildRow(
                label: '截止兌換期限',
                suffix: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: expirationTime),
                      if (c.detail?.orderStatus == 7)
                        const TextSpan(
                          text: '（已過期）',
                          style: TextStyle(color: Color(0xffff3b30)),
                        ),
                    ],
                  ),
                ),
              ),
              buildRow(label: '已賺取積分', content: '${c.detail?.jifenN ?? 0}'),
              buildRow(label: '訂單編號', content: c.detail?.orderNo),
              buildRow(label: '購買時間', content: c.detail?.payTime),
            ],
          ),
        );
      },
    );
  }

  Widget buildRow({
    String label = '',
    String? content,
    Color? contentColor,
    Widget? suffix,
  }) {
    return AppSimpleRow(
      radius: 0,
      height: 40.w,
      border: const Border(
        bottom: BorderSide(
          width: 1,
          color: Color.fromRGBO(230, 230, 230, 0.5),
        ),
      ),
      expanded: Text(
        '$label：',
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color.fromRGBO(0, 0, 0, 0.4),
        ),
      ),
      suffix: suffix ??
          Text(
            content ?? '',
            style: TextStyle(
              fontSize: 12.sp,
              color: contentColor,
            ),
          ),
    );
  }
}
