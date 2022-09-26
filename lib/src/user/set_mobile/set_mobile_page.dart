import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/focus_monitoring.dart';

import 'set_mobile_controller.dart';
import 'widgets/first_step_form.dart';
import 'widgets/second_step_form.dart';

class SetMobilePage extends StatefulWidget {
  const SetMobilePage({Key? key}) : super(key: key);

  @override
  _SetMobilePageState createState() => _SetMobilePageState();
}

class _SetMobilePageState extends State<SetMobilePage> {
  final controller = Get.put(SetMobileController());

  @override
  Widget build(BuildContext context) {
    return FocusMonitoring(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('更改電話號碼'),
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
                    return const SetMobileSecondStepForm();
                  }
                  return const SetMobileFirstStepForm();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
