import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_button.dart';

class OrderItemFooter extends StatelessWidget {
  final int? orderStatus;
  final int? payStatus;
  final bool canIGive;
  final bool canIExchange;

  const OrderItemFooter({
    Key? key,
    this.orderStatus,
    this.payStatus,
    this.canIGive = false,
    this.canIExchange = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (payStatus == 2) {
      if (orderStatus == 1) {
        if (canIExchange) {
          children.add(buildFooterItem(
            text: '現在兌換',
            background: const Color(0xfffffdeb),
          ));
        }
        if (canIGive) {
          children.add(buildFooterItem(
            text: '贈送好友',
          ));
        }
      } else {
        children.addAll([
          buildFooterItem(
            text: '查看詳情',
            background: const Color(0xfffffdeb),
          ),
        ]);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: children,
    );
  }

  Widget buildFooterItem({
    String? text,
    Color? background,
    Function()? onTap,
  }) {
    return Container(
      width: 96.w,
      height: 32.w,
      margin: EdgeInsets.only(left: 10.w),
      child: AppButton(
        backgroundColor: background,
        text: text,
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color.fromRGBO(0, 0, 0, 0.9),
        ),
      ),
    );
  }
}
