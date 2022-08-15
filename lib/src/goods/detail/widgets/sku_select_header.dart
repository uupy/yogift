import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class SkuSelectHeader extends StatelessWidget {
  final Skus sku;
  const SkuSelectHeader({Key? key, required this.sku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppSimpleRow(
      margin: EdgeInsets.all(20.w),
      prefix: AppImage(
        width: 90.w,
        height: 90.w,
        radius: 9.r,
        url: sku.cCoverImg,
      ),
      expanded: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${sku.buyPrice ?? 0}',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
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
                  '已選',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
