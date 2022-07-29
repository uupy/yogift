import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_row.dart';
import 'package:yo_gift/widgets/goods_sending_tag.dart';

class GoodsDetailBaseInfo extends StatelessWidget {
  const GoodsDetailBaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GetBuilder<GoodsDetailController>(
        builder: (c) {
          final sendingMethod = (c.detail?.sendingMethod ?? 1).toInt();
          final favorite = c.detail?.favorite ?? 0;
          final buy1Get1Free = c.detail?.buy1Get1FREE;
          final originalPrice = c.detail?.originalPrice;

          return Column(
            children: [
              AppRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                body: Column(
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
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        AppAssetImage(
                          img: 'icon_heart_$favorite.png',
                          width: 20.w,
                        ),
                        Text(
                          '願望清單',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(0, 0, 0, 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.w),
              Row(
                children: [
                  Text(
                    '\$${c.detail?.buyPrice ?? ''}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
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
                  if (buy1Get1Free == 0 && (originalPrice?.isNotEmpty ?? false))
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        '\$$originalPrice',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.26),
                          decoration: TextDecoration.lineThrough,
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
                body: Text(
                  c.detail?.bussinessName ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff007aff),
                    decoration: TextDecoration.underline,
                  ),
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
                body: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, .6),
                    ),
                    children: [
                      const TextSpan(text: '本券之兌換期為購買當日至'),
                      TextSpan(
                        text: '${c.detail?.effectiveDays ?? 0}天',
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
