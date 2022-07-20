import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/src/user/widgets/score_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

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
              AppImage(
                width: 86.r,
                height: 86.r,
                radius: 86.r,
                margin: EdgeInsets.only(right: 20.w),
                color: Colors.white,
              ),
              buildTextButton(text: '登入'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: buildBoldText('/'),
              ),
              buildTextButton(text: '註冊'),
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
      child: buildBoldText(text),
    );
  }

  Widget buildBoldText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff414042),
      ),
    );
  }
}
