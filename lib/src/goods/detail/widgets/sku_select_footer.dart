import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/widgets/app_button.dart';

class SkuSelectFooter extends StatelessWidget {
  final Skus sku;
  final String buyType;
  final Function()? onTap;

  const SkuSelectFooter({
    Key? key,
    required this.sku,
    this.buyType = '1',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = sku.buyPrice ?? 0;
    String buttonName = '送給自己';

    if (buyType == '2') {
      buttonName = '送給好友';
    } else if (buyType == '3') {
      buttonName = '拜托好友';
    }

    if (sku.amount == 0 || sku.id == 0) {
      return Container(
        height: 68.w,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 140.w,
              height: 40.w,
              child: AppButton(
                text: sku.id == 0 ? '暫未上架' : '暫無庫存',
                disabled: true,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 68.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xfffffdeb),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '總額 ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                  TextSpan(
                    text: '\$$total',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 140.w,
            height: 40.w,
            child: AppButton(
              text: buttonName,
              shadow: true,
              disabled: total == 0,
              onPressed: () {
                Navigator.pop(context);
                onTap?.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}
