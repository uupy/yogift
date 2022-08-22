import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/models/user_order/order_list_item.dart';
import 'package:yo_gift/widgets/app_button.dart';

class OrderItemFooter extends StatelessWidget {
  final OrderListItemVo item;
  final Function()? onClosed;
  final Function()? onCheckDetails;

  const OrderItemFooter({
    Key? key,
    required this.item,
    this.onClosed,
    this.onCheckDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderStatus = item.orderStatus;
    final payStatus = item.payStatus;
    final deliveryTime = item.deliveryTime ?? '';
    final receivingTime = item.receivingTime ?? '';
    final canIGive = item.canIGive == 1;
    final canIExchange = item.canIExchange == 1;

    String tips = '';
    Color tipsColor = const Color(0xff7dc878);
    List<Widget> children = [];

    if (payStatus == 1) {
      children.addAll([
        buildFooterItem(
          text: '關閉訂單',
          background: const Color(0xfffffdeb),
          onTap: onClosed,
        ),
        buildFooterItem(
          text: '繼續支付',
        ),
      ]);
    } else if (payStatus == 2) {
      switch (orderStatus) {
        case 3:
          if (deliveryTime.isNotEmpty) {
            tips =
                '預計${CommonUtils.formatDateByString(deliveryTime, 'yyyy-MM-dd')}送達';
            tipsColor = const Color(0xffff8d00);
          }
          break;
        case 4:
          if (item.sendingMethod == 2) {
            tips = '收貨時間：$receivingTime';
          } else {
            tips = '兌換時間：$receivingTime';
          }
          break;
        case 7:
          tips = '該商品已過期';
          tipsColor = const Color(0xffff3b30);
          break;
      }
      if (orderStatus == 1) {
        if (canIExchange) {
          children.add(buildFooterItem(
            text: '現在兌換',
            background: const Color(0xfffffdeb),
            onTap: () {
              Get.toNamed('/pages/mine/gift/exchange/index', parameters: {
                'id': item.oGuid!,
              });
            },
          ));
        }
        if (canIGive) {
          children.add(buildFooterItem(
            text: '贈送好友',
            onTap: () {
              Get.toNamed('/pages/mine/order/give-friend/index', parameters: {
                'orderId': item.oGuid!,
              });
            },
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
    }
    return Row(
      children: [
        Expanded(
          child: Text(
            tips,
            style: TextStyle(color: tipsColor),
          ),
        ),
        ...children
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
