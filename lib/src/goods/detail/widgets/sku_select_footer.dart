import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_button.dart';

class SkuSelectFooter extends StatelessWidget {
  final num? total;
  final Function()? onTap;

  const SkuSelectFooter({Key? key, this.total, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    text: '\$${total ?? 0}',
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
              text: '送給好友',
              shadow: true,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
