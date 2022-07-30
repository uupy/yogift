import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/goods/step_bar.dart';

class ProgressStepBar extends StatelessWidget {
  const ProgressStepBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'ProgressStepBar',
      builder: (c) {
        return StepBar(
          steps: const ['填寫心意卡', '結賬', '即時送出'],
          current: c.currentStep,
        );
      },
    );
  }
}
