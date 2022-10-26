import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';
import 'package:yo_gift/widgets/expandable_rich_text.dart';

import '../blessing_controller.dart';
import 'input_number.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CharityBlessingController>(
      id: 'DetailInfo',
      builder: (c) {
        final item = c.detail;
        final shopName = item?.bussinessName ?? '';
        final buyPrice = item?.buyPriceForCharity ?? 0;

        return AppCard(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSimpleRow(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                prefix: buildImg(item?.cCoverImg),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.giftName ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
                      child: Text(
                        '由$shopName售出',
                        style: TextStyle(
                          color: const Color(0xffff8d00),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '\$${Decimal.parse(buyPrice.toString())}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                          height: 30.w,
                          child: InputNumber(
                            onChanged: (value) {
                              c.addForm.quantity = value;
                              if(c.couponType == 2) {
                                c.discountPrice = c.discountAmount * value;
                                c.couponText = '- \$${c.discountPrice}';
                              }
                              c.update(['BlessingFooter','useCouponController2']);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 24.w),
              Text(
                '兌換條款及細則',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
              ExpandableRichText(
                content: item?.exchangeTerms,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildImg(String? url) {
    return AppImage(
      width: 90.w,
      height: 90.w,
      radius: 12.r,
      margin: EdgeInsets.only(right: 8.w),
      url: url,
      color: Colors.white,
      border: Border.all(
        width: 0.5,
        color: const Color(0xfff5f5f5),
      ),
    );
  }
}
