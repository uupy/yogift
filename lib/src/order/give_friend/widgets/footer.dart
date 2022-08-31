import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

import '../give_friend_controller.dart';

class OrderGiveFriendFooter extends StatelessWidget {
  final Function()? onTap;

  const OrderGiveFriendFooter({Key? key, this.onTap}) : super(key: key);

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
      child: GetBuilder<OrderGiveFriendController>(
        id: 'OrderGiveFriendFooter',
        builder: (c) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 140.w,
                child: AppButton(
                  onPressed: onTap,
                  disabled: c.submitting,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (c.submitting)
                        Container(
                          height: 17,
                          width: 17,
                          margin: EdgeInsets.only(right: 5.w),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      if (!c.submitting)
                        AppAssetImage(
                          img: 'icon_mine_gift.png',
                          width: 16.w,
                          margin: EdgeInsets.only(right: 5.w),
                        ),
                      Text(
                        '贈送好友',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
