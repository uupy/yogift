import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class CharityPayResultFooter extends StatelessWidget {
  final Function()? onTrack;

  const CharityPayResultFooter({Key? key, this.onTrack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppSimpleRow(
      height: 40.w,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.w),
      children: [
        Expanded(
          child: AppButton(
            text: '返回主頁',
            backgroundColor: const Color(0xfffffdeb),
            onPressed: () {
              Get.offAllNamed('/index');
            },
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: AppButton(
            text: '追蹤狀態',
            onPressed: onTrack,
          ),
        ),
      ],
    );
  }
}
