import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/goods/step_bar.dart';

import '../deliver_controller.dart';

class DeliverProgressStepBar extends StatelessWidget {
  const DeliverProgressStepBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftDeliverController>(
      id: 'DeliverProgressStepBar',
      builder: (c) {
        return StepBar(
          steps: const ['填寫收貨地址', '商家準備中', '已發貨', '確認收貨'],
          padding: 20.w,
          current: c.currentStep,
        );
      },
    );
  }
}
