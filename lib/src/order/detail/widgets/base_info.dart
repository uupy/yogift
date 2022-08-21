import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../detail_controller.dart';

class OrderDetailBaseInfo extends StatelessWidget {
  const OrderDetailBaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      id: 'OrderDetailBaseInfo',
      builder: (c) {
        return Container(
          margin: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 0),
          child: Column(
            children: [
              buildRow('已總付', '\$${c.detail?.orderMoney ?? 0}'),
              buildRow('截止兌換期限', c.detail?.expirationTime ?? ''),
              buildRow('已賺取積分', '${c.detail?.jifenN ?? 0}'),
              buildRow('訂單編號', c.detail?.orderNo ?? ''),
              buildRow('購買時間', c.detail?.payTime ?? ''),
            ],
          ),
        );
      },
    );
  }

  Widget buildRow(String label, String content) {
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
      suffix: Text(
        content,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
