import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/widgets/app_button.dart';

class FreeOneTips extends StatelessWidget {
  const FreeOneTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AppController>();
    final config = c.config?.setupConfig;

    return Container(
      height: 330.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Html(data: config?.freeOneText?.value),
            ),
          ),
          Container(
            width: 140.w,
            margin: EdgeInsets.only(top: 16.w),
            child: AppButton(
              backgroundColor: const Color(0xffff3b30),
              borderColor: const Color(0xffff3b30),
              text: config?.freeOneBtnText?.value,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              ),
              onPressed: () {
                SmartDialog.dismiss();
              },
            ),
          ),
        ],
      ),
    );
  }
}
