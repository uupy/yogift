import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'item_text.dart';

class OrderItemHeader extends StatelessWidget {
  final String? date;
  final String? name;

  const OrderItemHeader({
    Key? key,
    this.date,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppSimpleRow(
      height: 49.w,
      radius: 0,
      border: const Border(
        bottom: BorderSide(
          width: 1,
          color: Color.fromRGBO(230, 230, 230, 0.5),
        ),
      ),
      expanded: ItemText(
        label: '贈送日期：',
        content: date,
      ),
      suffix: ItemText(
        label: '贈送者：',
        content: name,
      ),
    );
  }
}
