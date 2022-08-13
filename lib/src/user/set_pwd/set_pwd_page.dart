import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'set_pwd_controller.dart';
import 'widgets/first_step_form.dart';
import 'widgets/second_step_form.dart';

class SetPwdPage extends StatefulWidget {
  const SetPwdPage({Key? key}) : super(key: key);

  @override
  _SetPwdPageState createState() => _SetPwdPageState();
}

class _SetPwdPageState extends State<SetPwdPage> {
  final controller = Get.put(SetPwdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改密碼'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const AppAssetImage(img: 'bg_top2.png'),
            Container(
              margin: EdgeInsets.only(bottom: 30.w, top: 32.w),
              padding: EdgeInsets.symmetric(horizontal: 38.w),
              child: Obx(() {
                final step = controller.step.value;
                if (step == 2) {
                  return const SetPwdSecondStepForm();
                }
                return const SetPwdFirstStepForm();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
