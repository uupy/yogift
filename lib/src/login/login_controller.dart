import 'dart:async';

import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/models/auth.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/services/verification.dart';

class LoginController extends GetxController {
  final formData = LoginFormDataVo();
  final appController = Get.put(AppController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final submitting = false.obs;
  /// 0 = 密碼登入， 1 = 驗證碼登入
  int loginType = 0;

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

  bool get submitAble {
    final pwdNotEmpty = formData.password?.isNotEmpty ?? false;
    final codeNotEmpty = formData.code?.isNotEmpty ?? false;
    final notEmpty = loginType == 0 ? pwdNotEmpty : codeNotEmpty;

    return !submitting.value && notEmpty;
  }

  Future getCode() async {
    final data = SendDataVo(
      phone: formData.phone,
      prefix: formData.phoneprefix,
    );
    await VerificationService.getCodeForLogin(data);
    runTimer();
  }

  /// 登录提交
  Future onSubmit() async {
    final form = formKey.currentState;
    if (submitting.value) return;
    if (form?.validate() ?? false) {
      form?.save();
      submitting(true);
      try {
        if (loginType == 0) {
          await AuthService.loginByPassword(formData);
        } else {
          await AuthService.loginByCode(formData);
        }
        app.toastSuccess('登入成功');
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
    update();
    _timer = Timer.periodic(_timeout, (timer) {
      countdown--;
      if (countdown <= 0) {
        stopTimer();
      }
      update();
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
