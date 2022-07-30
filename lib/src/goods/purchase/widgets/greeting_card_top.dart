import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/animated_button.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class GreetingCardTop extends StatelessWidget {
  final bool isEdit;
  final Function()? onPressed;

  const GreetingCardTop({
    Key? key,
    this.isEdit = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppSimpleRow(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
      color: Colors.transparent,
      expanded: Text(
        '給他/她的留言：',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(0, 2.w),
              blurRadius: 4.w,
              color: const Color.fromRGBO(0, 0, 0, 0.65),
            ),
          ],
        ),
      ),
      suffix: AnimatedButton(
        onPressed: onPressed,
        width: 64.w,
        height: 26.w,
        color: const Color.fromRGBO(0, 0, 0, 0.6),
        borderColor: const Color.fromRGBO(0, 0, 0, 0.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImage(
              width: 16.w,
              img: 'icon_edit3.png',
            ),
            SizedBox(width: 6.w),
            Text(
              isEdit ? '完成' : '編輯',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
