import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';
import 'package:yo_gift/widgets/shop_name_link.dart';

import 'order_detail_image.dart';

class OrderDetailCard extends StatelessWidget {
  final OrderDetailItemVo? item;

  const OrderDetailCard({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sku = item?.skuContent ?? '';
    final expirationTime = item?.expirationTime ?? '';

    return AppCard(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w, bottom: 12.w),
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
      child: Column(
        children: [
          SizedBox(height: 15.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailImage(
                url: item?.cCoverImg ?? '',
                sendingMethod: item?.sendingMethod,
                onTap: () {
                  Get.toNamed('/pages/goods/detail/index', parameters: {
                    'id': item?.gGuid ?? '',
                  });
                },
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSimpleRow(
                      expanded: Text(
                        item?.giftName ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      suffix: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'x${item?.nums ?? 0}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ),
                      ),
                    ),
                    if (sku.isNotEmpty)
                      AppSimpleRow(
                        margin: EdgeInsets.only(top: 2.w, bottom: 2.w),
                        expanded: Text(
                          sku,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ),
                      ),
                    ShopNameLink(
                      name: item?.bussinessName ?? '',
                      id: item?.bGuid,
                    ),
                    AppSimpleRow(
                      margin: EdgeInsets.only(
                          top: sku.isNotEmpty ? 4.w : 10.w, bottom: 4.w),
                      expanded: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                          children: [
                            const TextSpan(
                              text: '截止兌換期限：',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            ),
                            TextSpan(
                              text: expirationTime.isNotEmpty
                                  ? CommonUtils.formatDateByString(
                                      expirationTime, 'yyyy-MM-dd')
                                  : '',
                              style: const TextStyle(
                                color: Color(0xffff3b30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppSimpleRow(
                      expanded: Text(
                        '\$${item?.buyPrice ?? 0}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
