import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_row.dart';
import 'package:yo_gift/widgets/goods/favorite_button.dart';
import 'package:yo_gift/widgets/goods/goods_sending_tag.dart';
import 'package:yo_gift/widgets/shop_name_link.dart';

class GoodsDetailBaseInfo extends StatelessWidget {
  const GoodsDetailBaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GetBuilder<GoodsDetailController>(
        id: 'GoodsDetailBaseInfo',
        builder: (c) {
          final sendingMethod = (c.detail?.sendingMethod ?? 1).toInt();
          final favorite = c.detail?.favorite ?? 0;
          final buy1Get1Free = c.detail?.buy1Get1FREE;
          final originalPrice = c.detail?.originalPrice;
          final price = c.detail?.buyPrice ?? 0;
          final effectiveDays = c.detail?.effectiveDays ?? 0;
          final effectiveTime = c.detail?.effectiveTime ?? '';

          return Column(
            children: [
              AppRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.detail?.giftName ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 6.w),
                    GoodsSendingTag(method: sendingMethod),
                  ],
                ),
                suffix: [
                  SizedBox(width: 15.w),
                  if (c.detail != null)
                    FavoriteButton(
                      guid: c.detail?.gGuid,
                      favorite: favorite,
                    ),
                ],
              ),
              SizedBox(height: 8.w),
              Row(
                children: [
                  Text(
                    '\$${Decimal.parse(price.toString())}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (originalPrice?.isNotEmpty ?? false)
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        '\$$originalPrice',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.26),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  if (buy1Get1Free == 1)
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        '買一送一',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xffff3b30),
                        ),
                      ),
                    ),
                ],
              ),
              AppRow(
                margin: EdgeInsets.only(top: 8.w),
                prefix: [
                  AppAssetImage(
                    width: 16.w,
                    margin: EdgeInsets.only(right: 8.w),
                    img: 'icon_shop.png',
                  ),
                ],
                expanded: ShopNameLink(
                  name: c.detail?.bussinessName ?? '',
                  id: c.detail?.bGuid,
                ),
              ),
              AppRow(
                margin: EdgeInsets.only(top: 8.w),
                prefix: [
                  AppAssetImage(
                    width: 16.w,
                    margin: EdgeInsets.only(right: 8.w),
                    img: 'icon_time.png',
                  ),
                ],
                expanded: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, .6),
                    ),
                    children: [
                      const TextSpan(text: '本券之兌換期為購買當日至'),
                      TextSpan(
                        text: effectiveTime.isEmpty
                            ? '$effectiveDays天'
                            : CommonUtils.formatDateByString(
                                effectiveTime, 'yyyy-MM-dd'),
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '止'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
