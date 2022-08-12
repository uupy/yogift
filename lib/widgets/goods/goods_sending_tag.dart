import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class GoodsSendingTag extends StatelessWidget {
  final int method;

  const GoodsSendingTag({
    Key? key,
    this.method = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = const Color(0xff7dc878);
    String text = '到店兌換';

    if (method == 2) {
      background = const Color(0xffffe100);
      text = '免費送貨';
    } else if (method == 3) {
      background = const Color(0xff5F97FF);
      text = '網上兌換';
    }

    return Container(
      width: 70.w,
      height: 18.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      ),
      child: Row(
        children: [
          AppAssetImage(
            width: 14.w,
            margin: EdgeInsets.only(right: 3.w),
            img: 'icon_get_type_$method.png',
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
