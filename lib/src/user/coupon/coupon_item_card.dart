import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/models/coupon_item.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/text_view_more.dart';

/// 优惠券
class CouponItemCard extends StatelessWidget {
  final CouponItem item;

  const CouponItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.w),
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
        child: Column(children: [
          /// 上部分
          item.ygcouponType == 1
            ? Row(
              children: [
                /// 優惠券
                buildCouponTitle(item),
                SizedBox(
                  width: 40.w,
                ),
                buildRightCouponTitle(item),
              ],
            )
            : Row(
              children: [
                /// 折扣券
                buildDiscountTile(item),
                SizedBox(
                  width: 40.w,
                ),
                buildRightCouponTitle(item),
              ],
            ),
          
          /// 過期時間
          Container(
            padding: EdgeInsets.fromLTRB(0,8.w,0,8.w),
            margin: EdgeInsets.only(bottom: 8.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(230, 230, 230, .5)
                )
              )
            ),
            child:  Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${item.endTime}前有效',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(255,188,100,1)
                ),
              ),
            ),
          ),

          /// 使用條款
          ReadMoreText(
            '${item.termsOfUse?.replaceAll('<br />', '\n')}',
            numLines: 1,
            readMoreText: '查看更多',
            readLessText: '',
            style: TextStyle(
              color: const Color.fromRGBO(163, 163, 163, 1),
              fontSize: 12.sp,
            ),
          )
        ]
      )
    );
  }
}

buildCouponTitle(item) {
  return Column(
    children: [
      Text(
        '\$${item.cash?.toInt()}',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
      ),
      Text('優惠券', style: TextStyle(fontSize: 14.sp))
    ],
  );
}

buildDiscountTile(item) {
  return Column(
    children: [
      Text(
        '${(item.cash! / 10)}折',
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
      Text('折扣券',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))
    ],
  );
}

buildRightCouponTitle(item) {
  return Column(
    children: [
      Text(
        '${item.ygcouponTitle1}',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
      ),
      SizedBox(
        height: 8.w,
      ),
      Text(
        '滿${item.minimumAmount}可用',
        style: TextStyle(
            fontSize: 12.sp, color: const Color.fromRGBO(163, 163, 163, 1)),
      ),
    ],
  );
}
