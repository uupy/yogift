import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/user/widgets/score_card.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class UserBaseInfo extends StatelessWidget {
  const UserBaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 86.r,
                height: 86.r,
                margin: EdgeInsets.only(right: 20.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(86.r),
                  ),
                ),
                child: const AppAssetImage(
                  img: 'icon_star.png',
                ),
              ),
              buildTextButton(
                text: '登入',
                onPressed: () {
                  Get.toNamed('/login');
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: buildBoldText('/'),
              ),
              buildTextButton(
                text: '註冊',
                onPressed: () {
                  Get.toNamed('/register');
                },
              ),
            ],
          ),
          const UserScoreCard(),
        ],
      ),
    );
  }

  Widget buildTextButton({String text = '', Function()? onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: buildBoldText(text, true),
    );
  }

  Widget buildBoldText(String text, [bool underline = false]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff414042),
        decoration: underline ? TextDecoration.underline : null,
      ),
    );
  }
}
