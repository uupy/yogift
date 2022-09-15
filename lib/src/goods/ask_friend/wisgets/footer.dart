import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

import '../ask_friend_controller.dart';

class AskFriendFooter extends StatelessWidget {
  final Function()? onTap;

  const AskFriendFooter({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      color: Colors.transparent,
      child: GetBuilder<AskFriendController>(
        builder: (c) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 140.w,
                child: buildFooterItem(
                  text: '拜託好友',
                  icon: 'icon_please.png',
                  loading: c.submitting,
                  onTap: onTap,
                ),
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
    return AppButton(
      onPressed: onTap,
      backgroundColor: background,
      disabled: loading,
      shadow: true,
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
    );
  }
}
