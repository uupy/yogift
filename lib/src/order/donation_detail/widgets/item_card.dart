import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../donation_detail_controller.dart';
import 'item_image.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationDetailController>(
      id: 'OrderItemCard',
      builder: (c) {
        final item = c.detail;
        final sku = item?.skuContent ?? '';

        return AppCard(
          margin:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w, bottom: 12.w),
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
          child: Column(
            children: [
              SizedBox(height: 15.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderItemImage(
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
                        AppSimpleRow(
                          margin: EdgeInsets.only(
                              bottom: sku.isNotEmpty ? 4.w : 20.w, top: 2.w),
                          expanded: Text(
                            '由${item?.bussinessName ?? ''}售出',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffff8d00),
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
      },
    );
  }
}
