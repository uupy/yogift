import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';
import 'package:yo_gift/widgets/progress_bar.dart';

import '../detail_controller.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CharityDetailController>(
      id: 'FavoritesList',
      builder: (c) {
        return Column(
          children: c.list.map((item) {
            final price = item.buyPriceForCharity ?? 0;
            final buyPrice = item.buyPrice ?? 0;
            final isDone = item.quantityGet == item.quantity;
            final showDeliveryTime = isDone && item.status == 3;

            return AppCard(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.w),
              blurRadius: 2.w,
              child: Column(
                children: [
                  AppSimpleRow(
                    width: double.maxFinite,
                    prefix: AppImage(
                      width: 90.w,
                      height: 90.w,
                      margin: EdgeInsets.only(right: 12.w),
                      url: item.cCoverImg,
                      color: Colors.white,
                      radius: 12.r,
                      border: Border.all(
                        width: 0.5,
                        color: const Color(0xffe6e6e6),
                      ),
                    ),
                    expanded: Stack(
                      children: [
                        SizedBox(height: 90.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.giftName ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Text(
                              item.bussinessName ?? '',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xffff8d00),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Row(
                            children: [
                              Text(
                                '\$${Decimal.parse(price.toString())}',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              if (price != buyPrice)
                                Text(
                                  '\$$buyPrice',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(0, 0, 0, 0.26),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 12.w,
                          right: 0,
                          height: 32.w,
                          child: AppButton(
                            text: '已達標',
                            disabled: isDone,
                            onPressed: () {
                              Get.toNamed('/pages/charity/blessing/index',
                                  parameters: {
                                    'wishId': item.fGuid!,
                                    'orgId': item.cGuid!,
                                  });
                            },
                            child: !isDone
                                ? Row(
                                    children: [
                                      AppAssetImage(
                                        width: 16.w,
                                        margin: EdgeInsets.only(right: 4.w),
                                        img: 'icon_give.png',
                                      ),
                                      Text(
                                        '捐贈',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.9),
                                        ),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProgressBar(
                    total: item.quantity ?? 0,
                    completed: item.quantityGet ?? 0,
                  ),
                  if (!showDeliveryTime)
                    AppSimpleRow(
                      margin: EdgeInsets.only(top: 12.w),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      prefix: Text(
                        '截止時間 ${item.expiryDate}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ),
                      expanded: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Text(
                          item.remark ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xffff3b30),
                          ),
                        ),
                      ),
                    ),
                  if (showDeliveryTime)
                    AppSimpleRow(
                      margin: EdgeInsets.only(top: 12.w),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      prefix: Text(
                        '預計送貨日期 ${item.deliveryTime ?? ''}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xffff3b30),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
