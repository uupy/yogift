import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/services/verification.dart';

class SetPwdController extends GetxController {
  final formData1 = CheckCodeDataVo();
  final formData2 = ResetPwdFormVo();
  final formKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();
  final isChecking = false.obs;
  final submitting = false.obs;
  final step = 1.obs;

  String? confirmPassword;

  /// 轮询间隔时间
  static const _timeout = Duration(seconds: 1);

  /// 定时器
  Timer? _timer;

  /// 发送验证码倒计时
  int countdown = 0;

  bool get phoneNotEmpty {
    final prefixNotEmpty = formData1.prefix?.isNotEmpty ?? false;
    final phoneNotEmpty = formData1.phone?.isNotEmpty ?? false;
    return prefixNotEmpty && phoneNotEmpty;
  }

  bool get getCodeAble {
    return phoneNotEmpty && countdown <= 0;
  }

  bool get nextStepAble {
    final codeNotEmpty = formData1.code?.isNotEmpty ?? false;
    return codeNotEmpty && phoneNotEmpty;
  }

  /// 是否可提交修改
  bool get submitAble {
    final pwdNotEmpty = formData2.password?.isNotEmpty ?? false;
    final pwdNotEmpty2 = confirmPassword?.isNotEmpty ?? false;
    return !submitting.value && pwdNotEmpty && pwdNotEmpty2;
  }

  Future getCode() async {
    final data = SendDataVo(
      phone: formData1.phone,
      prefix: formData1.prefix,
    );
    await VerificationService.getCodeForResetPwd(data);
    runTimer();
  }

  Future checkCode() async {
    isChecking(true);
    update(['FirstStepForm']);
    try {
      await VerificationService.checkResetPwdCode(formData1);
      step(2);
    } finally {
      isChecking(false);
      update(['FirstStepForm']);
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
        formData2.code = formData1.code;
        formData2.phone = formData1.phone;
        formData2.phoneprefix = formData1.prefix;

        await UserService.resetPassword(formData2);

        app.showToast('修改成功');

        Get.back(result: true);
      } finally {
        submitting(false);
        update(['SecondStepForm']);
      }
    }
  }

  /// 开启定时器
  void runTimer() {
    stopTimer();
    countdown = 60;
    update(['FirstStepForm']);
    _timer = Timer.periodic(_timeout, (timer) {
      countdown--;
      if (countdown <= 0) {
        stopTimer();
      }
      update(['FirstStepForm']);
    });
  }

  /// 关闭定时器
  void stopTimer() async {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
