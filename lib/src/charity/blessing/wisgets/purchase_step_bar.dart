import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/goods/step_bar.dart';

import '../blessing_controller.dart';

class ProgressStepBar extends StatelessWidget {
  const ProgressStepBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CharityBlessingController>(
      id: 'ProgressStepBar',
      builder: (c) {
        return StepBar(
          steps: const ['捐贈', '達標', '自動送貨'],
          current: c.currentStep,
        );
      },
    );
  }
}
