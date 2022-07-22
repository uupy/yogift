import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/models/auth.dart';
import 'package:yo_gift/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formData = PhonePasswordVo();
  final appController = Get.put(AppController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final submitting = false.obs;

  /// 登录提交
  Future onSubmit() async {
    final form = formKey.currentState;
    if (submitting.value) return;
    if (form?.validate() ?? false) {
      form?.save();
      submitting(true);
      try {
        final res = await AuthService.loginByPassword(formData);
        final data = res.data['data'] ?? {};
      } finally {
        submitting(false);
        update();
      }
    }
  }
}
