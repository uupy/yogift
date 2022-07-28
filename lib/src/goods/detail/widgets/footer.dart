import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

class GoodsDetailFooter extends StatelessWidget {
  const GoodsDetailFooter({Key? key}) : super(key: key);

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
      child: Row(
        children: [
          buildFooterItem(
            text: '拜託',
            icon: 'icon_please.png',
            background: const Color(0xfffffdeb),
          ),
          SizedBox(width: 15.w),
          buildFooterItem(
            text: '贈送',
            icon: 'icon_mine_gift.png',
          ),
        ],
      ),
    );
  }

  Widget buildFooterItem({
    String? text,
    String? icon,
    Color? background,
    Function()? onTap,
  }) {
    return Expanded(
      child: AppButton(
        backgroundColor: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
