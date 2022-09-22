import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

class PurchaseFooter extends StatelessWidget {
  final Function()? onTap;

  const PurchaseFooter({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xfffffdeb),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: GetBuilder<PurchaseController>(
        id: 'PurchaseFooter',
        builder: (c) {
          final order = c.orderInfo;
          double price = c.detail?.buyPrice ?? 0;

          if (order != null) {
            price = order.orderMoney ?? 0;
          }

          return Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '總額 ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    Text(
                      '\$${Decimal.parse(price.toString())}',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.w),
              buildFooterItem(
                text: c.isGiveToSelf ? '贈送自己' : '贈送好友',
                icon: 'icon_mine_gift.png',
                loading: c.submitting,
                onTap: onTap,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildFooterItem({
    String? text,
    String? icon,
    Color? background,
    bool loading = false,
    Function()? onTap,
  }) {
    return Expanded(
      child: AppButton(
        onPressed: onTap,
        disabled: loading,
        backgroundColor: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (loading)
              Container(
                height: 17,
                width: 17,
                margin: EdgeInsets.only(right: 5.w),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            if (!loading)
              AppAssetImage(
                img: icon,
                width: 16.w,
                margin: EdgeInsets.only(right: 5.w),
              ),
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
