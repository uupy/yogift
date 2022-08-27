import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class SkuSelectHeader extends StatelessWidget {
  final Skus sku;
  final String? defaultCoverImg;
  final String? selectName;

  const SkuSelectHeader({
    Key? key,
    required this.sku,
    this.defaultCoverImg,
    this.selectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalPrice = sku.originalPrice ?? 0;
    final price = sku.buyPrice ?? 0;
    String img = sku.cCoverImg ?? '';

    if (img.isEmpty) {
      img = defaultCoverImg ?? '';
    }

    if (sku.id == 0) {
      return SizedBox(
        height: 40.w,
        child: Align(
          alignment: Alignment.centerRight,
          child: AppAssetImage(
            width: 24.w,
            margin: EdgeInsets.only(right: 20.w, top: 6.w),
            img: 'icon_close.png',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }

    return IntrinsicHeight(
      child: AppSimpleRow(
        margin: EdgeInsets.all(20.w),
        prefix: AppImage(
          width: 90.w,
          height: 90.w,
          radius: 9.r,
          url: img,
        ),
        expanded: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${Decimal.parse(price.toString())} ',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (originalPrice > 0)
                      TextSpan(
                        text: '\$${Decimal.parse(originalPrice.toString())}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.26),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ),
              AppSimpleRow(
                prefix: Text(
                  '已選',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
                expanded: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    selectName ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
