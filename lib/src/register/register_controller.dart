import 'dart:async';

import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/services/verification.dart';

class RegisterController extends GetxController {
  final formData = RegisterFormVo();
  final updateFormData = UpdateInfoFormVo();
  final formKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();
  final submitting = false.obs;
  final step = 1.obs;

  String? confirmPassword;
  bool isAgreeTerms = true;

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

  bool get nextStepAble {
    final codeNotEmpty = formData.code?.isNotEmpty ?? false;
    return codeNotEmpty && phoneNotEmpty;
  }

  /// 是否可提交注册
  bool get submitAble {
    final pwdNotEmpty = formData.password?.isNotEmpty ?? false;
    final pwdNotEmpty2 = confirmPassword?.isNotEmpty ?? false;
    return !submitting.value && pwdNotEmpty && pwdNotEmpty2;
  }

  /// 是否可更新用户信息
  bool get updateAble {
    final notEmpty = updateFormData.birthday?.isNotEmpty ?? false;
    return !submitting.value && notEmpty;
  }

  Future getCode() async {
    final data = SendDataVo(
      phone: formData.phone,
      prefix: formData.phoneprefix,
    );
    await VerificationService.getCodeForRegister(data);
    runTimer();
  }

  /// 提交
  Future onSubmit() async {
    final form = formKey.currentState;
    if (submitting.value) return;
    if (form?.validate() ?? false) {
      form?.save();
      submitting(true);
      try {
        await UserService.register(formData);
        app.toastSuccess('註冊成功');
        step(3);
      } finally {
        submitting(false);
        update();
      }
    }
  }

  /// 更新用户信息
  Future onSubmitUpdate() async {
    final form = updateFormKey.currentState;
    if (submitting.value) return;
    if (form?.validate() ?? false) {
      form?.save();
      submitting(true);
      try {
        await UserService.updateInfo(updateFormData);
        Get.back(result: true);
      } finally {
        submitting(false);
        update();
      }
    }
  }

  /// 开启定时器
  void runTimer() {
    stopTimer();
    countdown = 60;
    update(['firstStepForm']);
    _timer = Timer.periodic(_timeout, (timer) {
      countdown--;
      if (countdown <= 0) {
        stopTimer();
      }
      update(['firstStepForm']);
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
