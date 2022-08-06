import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/index/user/user_controller.dart';
import 'package:yo_gift/src/index/user/widgets/header_has_logged.dart';

import 'header_not_logged.dart';
import 'score_card.dart';

class UserHeaderInfo extends StatelessWidget {
  const UserHeaderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: GetBuilder<UserController>(
        id: 'UserHeaderInfo',
        builder: (c) {
          return Column(
            children: [
              c.userInfo == null
                  ? HeaderNotLogged(
                      onLogged: () {
                        c.init();
                      },
                    )
                  : HeaderHasLogged(
                      avatar: c.userInfo?.headSrc,
                      phone: c.userInfo?.phone,
                      birthday: c.userInfo?.birthday,
                    ),
              const UserScoreCard(),
            ],
          );
        },
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
