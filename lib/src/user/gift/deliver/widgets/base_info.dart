import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../deliver_controller.dart';

class GiftDeliverBaseInfo extends StatelessWidget {
  const GiftDeliverBaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftDeliverController>(
      builder: (c) {
        final expirationTime = c.detail?.expirationTime ?? '';
        final orderStatus = c.detail?.orderStatus ?? 0;

        return Container(
          margin: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 0),
          child: Column(
            children: [
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
              buildRow(label: '購買時間', content: c.detail?.createTime),
              if (orderStatus > 2)
                buildRow(label: '發貨時間', content: c.detail?.deliveryTime),
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
