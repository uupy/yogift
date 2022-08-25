import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/src/order/constants.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class OrderItemHeader extends StatelessWidget {
  final String? date;
  final int? orderStatus;
  final int? payStatus;

  const OrderItemHeader({
    Key? key,
    this.date,
    this.orderStatus,
    this.payStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusName = OrderStatus.getLabelByValue(orderStatus) ?? '';
    Color statusColor = const Color(0xff7dc878);

    if (payStatus == 1) {
      statusName = '待支付';
      statusColor = const Color(0xffff8d00);
    }

    return AppSimpleRow(
      height: 49.w,
      radius: 0,
      border: const Border(
        bottom: BorderSide(
          width: 1,
          color: Color.fromRGBO(230, 230, 230, 0.5),
        ),
      ),
      expanded: Text(date ?? ''),
      suffix: Text(
        statusName,
        style: TextStyle(
          color: statusColor,
        ),
      ),
    );
  }
}
