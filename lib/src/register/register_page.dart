import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/register/widgets/second_step_form.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'register_controller.dart';
import 'widgets/first_step_form.dart';
import 'widgets/third_step_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊YO！GIFT'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const AppAssetImage(img: 'img_gift.png'),
            Container(
              margin: EdgeInsets.only(bottom: 30.w, top: 32.w),
              padding: EdgeInsets.symmetric(horizontal: 38.w),
              child: Obx(() {
                final step = controller.step.value;
                if (step == 2) {
                  return const RegisterSecondStepForm();
                } else if (step == 3) {
                  return RegisterThirdStepForm();
                }
                return const RegisterFirstStepForm();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
