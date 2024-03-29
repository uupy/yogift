import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/src/order/constants.dart';
import 'package:yo_gift/widgets/app_button.dart';

class OrderItemFooter extends StatelessWidget {
  final int? orderStatus;
  final int? payStatus;
  final bool canIGive;
  final bool canIExchange;
  final Function()? onCheckDetails;
  final Function()? onGiveFriend;

  const OrderItemFooter({
    Key? key,
    this.orderStatus,
    this.payStatus,
    this.canIGive = false,
    this.canIExchange = false,
    this.onCheckDetails,
    this.onGiveFriend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    String statusName = OrderStatus.getLabelByValue(orderStatus) ?? '';
    Color statusColor = const Color(0xffff8d00);

    if (orderStatus == 1) {
      if (canIExchange) {
        children.add(buildFooterItem(
          text: '現在兌換',
          background: const Color(0xfffffdeb),
          onTap: onCheckDetails,
        ));
      }
      if (canIGive) {
        children.add(buildFooterItem(
          text: '贈送好友',
          onTap: onGiveFriend,
        ));
      }
    } else {
      children.addAll([
        buildFooterItem(
          text: '查看詳情',
          background: const Color(0xfffffdeb),
          onTap: onCheckDetails,
        ),
      ]);
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            statusName,
            style: TextStyle(
              color: statusColor,
            ),
          ),
        ),
        ...children,
      ],
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
        onPressed: onTap,
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
