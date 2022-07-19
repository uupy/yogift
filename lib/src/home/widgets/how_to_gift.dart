import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/module_title.dart';

class HomeHowToGift extends StatelessWidget {
  const HomeHowToGift({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.h, 0, 30.h),
      color: const Color(0xfffefdee),
      child: Column(
        children: [
          const ModuleTitle(
            textCn: '如何即時送禮？',
            textEn: 'HOW TO GIFT？',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset('lib/assets/images/img_guide.png'),
          ),
          Container(
            width: 160.w,
            margin: EdgeInsets.only(top: 30.h),
            child: AppButton(
              text: '查看使用流程',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
