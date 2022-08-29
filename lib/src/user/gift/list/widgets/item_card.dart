import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/give.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'item_footer.dart';
import 'item_header.dart';
import 'item_image.dart';
import 'item_text.dart';

class OrderItemCard extends StatelessWidget {
  final GiveItemVo item;

  const OrderItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  void goOrderDetail() {
    final status = item.orderStatus;
    bool isDeliver = item.sendingMethod == 2 && [1, 2, 3, 4].contains(status);
    String path = '/pages/mine/order/detail/index';

    if (status == 1) {
      path = '/pages/mine/gift/exchange/index';
    } else if (isDeliver) {
      path = '/pages/mine/gift/deliver/index';
    }

    Get.toNamed(path, parameters: {
      'id': item.oGuid!,
    });
  }

  @override
  Widget build(BuildContext context) {
    final sku = item.skuContent ?? '';
    String name = item.nickName ?? '';

    if (name.isEmpty) {
      name = '${item.phonePrefix ?? ''} ${item.phone ?? ''}';
    }

    return AppCard(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
      child: Column(
        children: [
          OrderItemHeader(
            date: item.createTime,
            name: name,
          ),
          SizedBox(height: 15.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderItemImage(
                url: item.cCoverImg ?? '',
                sendingMethod: item.sendingMethod,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
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
                            top: sku.isNotEmpty ? 26.w : 48.w, bottom: 4.w),
                        expanded: ItemText(
                          label: '兌換期：',
                          content: item.expirationTime ?? '',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.w),
          OrderItemFooter(
            orderStatus: item.orderStatus,
            canIGive: item.canIGive == 1,
            canIExchange: item.canIExchange == 1,
            onCheckDetails: goOrderDetail,
          ),
        ],
      ),
    );
  }
}
