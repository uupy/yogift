import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

import '../blessing_controller.dart';

class AskFriendFooter extends StatelessWidget {
  final Function()? onTap;

  const AskFriendFooter({Key? key, this.onTap}) : super(key: key);

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
      child: GetBuilder<BlessingController>(
        builder: (c) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFooterItem(
                text: '拜託好友',
                icon: 'icon_please.png',
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
    Function()? onTap,
  }) {
    return Expanded(
      child: AppButton(
        onPressed: onTap,
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
