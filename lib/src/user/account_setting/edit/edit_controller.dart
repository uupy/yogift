import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/services/user.dart';

class AccountSettingEditController extends GetxController {
  final type = Get.parameters['type'];
  final initVal = Get.parameters['val'];
  final title = ''.obs;
  final submitting = false.obs;
  final inputController = TextEditingController();

  String inputVal = '';

  bool get submitAble {
    return !submitting.value && inputVal.isNotEmpty;
  }

  void init() {
    final titles = {
      'nickname': '修改暱稱',
      'email': '設置電郵',
    };
    inputVal = initVal ?? '';
    inputController.text = initVal ?? '';
    title(titles[type]);
    update();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future onSubmit() async {
    if (type == 'nickname') {
      await UserService.updateNickName(inputVal);
    } else if (type == 'email') {
      if (!CommonUtils.isEmail(inputVal)) {
        app.showToast('請輸入正確的郵箱格式');
        return;
      }
      await UserService.updateEmail(inputVal);
    }
    Get.back(result: true);
  }
}
