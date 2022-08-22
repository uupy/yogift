import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_list_item.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'item_footer.dart';
import 'item_header.dart';
import 'item_image.dart';

class OrderItemCard extends StatelessWidget {
  final OrderListItemVo item;
  final Function()? onClosed;

  const OrderItemCard({
    Key? key,
    required this.item,
    this.onClosed,
  }) : super(key: key);

  void goOrderDetail() {
    if (item.payStatus == 1) return;
    Get.toNamed('/pages/mine/order/detail/index', parameters: {
      'id': item.oGuid!,
    });
  }

  @override
  Widget build(BuildContext context) {
    final sku = item.skuContent ?? '';

    return AppCard(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.w),
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
      child: Column(
        children: [
          OrderItemHeader(
            date: item.createTime,
            payStatus: item.payStatus,
            orderStatus: item.orderStatus,
          ),
          SizedBox(height: 15.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderItemImage(
                url: item.cCoverImg ?? '',
                sendingMethod: item.sendingMethod,
                onTap: () {
                  Get.toNamed('/pages/goods/detail/index', parameters: {
                    'id': item.gGuid!,
                  });
                },
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: goOrderDetail,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSimpleRow(
                        expanded: Text(
                          item.giftName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        suffix: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '\$${item.buyPrice ?? 0}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      if (sku.isNotEmpty)
                        AppSimpleRow(
                          margin: EdgeInsets.only(top: 6.w),
                          expanded: Text(
                            sku,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),
                        ),
                      AppSimpleRow(
                        margin: EdgeInsets.only(
                            top: sku.isNotEmpty ? 6.w : 28.w, bottom: 4.w),
                        expanded: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                            children: [
                              const TextSpan(
                                text: '兌換期：',
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                              ),
                              TextSpan(
                                text: item.expirationTime ?? '',
                              ),
                            ],
                          ),
                        ),
                        suffix: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: Text(
                            'x${item.nums ?? 0}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),
                        ),
                      ),
                      AppSimpleRow(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '共${item.nums ?? 0}件',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                              children: [
                                const TextSpan(
                                  text: '總付：',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                ),
                                TextSpan(
                                  text: '\$${item.orderMoney ?? 0}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          OrderItemFooter(
            item: item,
            onClosed: onClosed,
            onCheckDetails: goOrderDetail,
          ),
        ],
      ),
    );
  }
}
