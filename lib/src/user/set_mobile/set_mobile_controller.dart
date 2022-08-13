import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/services/verification.dart';

class SetMobileController extends GetxController {
  final formData = SetPhoneFormVo();
  final updateFormKey = GlobalKey<FormState>();
  final isChecking = false.obs;
  final submitting = false.obs;
  final step = 1.obs;

  String verifyCode = '';

  /// 轮询间隔时间
  static const _timeout = Duration(seconds: 1);

  /// 定时器
  Timer? _timer;

  /// 发送验证码倒计时
  int countdown = 0;

  bool get phoneNotEmpty {
    final prefixNotEmpty = formData.phoneprefix?.isNotEmpty ?? false;
    final phoneNotEmpty = formData.phone?.isNotEmpty ?? false;
    return prefixNotEmpty && phoneNotEmpty;
  }

  bool get getCodeAble {
    return phoneNotEmpty && countdown <= 0;
  }

  /// 是否可提交修改
  bool get submitAble {
    final codeNotEmpty = formData.code?.isNotEmpty ?? false;
    return !submitting.value && codeNotEmpty && phoneNotEmpty;
  }

  Future getCode(int step) async {
    if (step == 2) {
      final data = SendDataVo(
        prefix: formData.phoneprefix,
        phone: formData.phone,
      );
      await VerificationService.getCodeForChangePhone(data);
    } else {
      await VerificationService.verifySend();
    }

    runTimer(step == 1 ? 'FirstStepForm' : 'SecondStepForm');
  }

  Future checkCode() async {
    isChecking(true);
    update(['FirstStepForm']);
    try {
      await VerificationService.checkVerifyCode(verifyCode);
      step(2);
      stopTimer();
    } finally {
      isChecking(false);
      update(['FirstStepForm', 'SecondStepForm']);
    }
  }

  /// 提交
  Future onSubmit() async {
    final form = updateFormKey.currentState;
    if (submitting.value) return;
    if (form?.validate() ?? false) {
      form?.save();
      submitting(true);
      update(['SecondStepForm']);
      try {
        await UserService.updatePhone(formData);

        app.showToast('修改成功');

        Get.back(result: true);
      } finally {
        submitting(false);
        update(['SecondStepForm']);
      }
    }
  }

  /// 开启定时器
  void runTimer(String updateId) {
    stopTimer();
    countdown = 60;
    update([updateId]);
    _timer = Timer.periodic(_timeout, (timer) {
      countdown--;
      if (countdown <= 0) {
        stopTimer();
      }
      update([updateId]);
    });
  }

  /// 关闭定时器
  void stopTimer() async {
    _timer?.cancel();
    countdown = 0;
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
