import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_input.dart';
import 'package:yo_gift/widgets/focus_monitoring.dart';

import 'edit_controller.dart';

class AccountSettingEditPage extends StatefulWidget {
  const AccountSettingEditPage({Key? key}) : super(key: key);

  @override
  _AccountSettingEditPageState createState() => _AccountSettingEditPageState();
}

class _AccountSettingEditPageState extends State<AccountSettingEditPage> {
  final controller = Get.put(AccountSettingEditController());

  @override
  Widget build(BuildContext context) {
    return FocusMonitoring(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.title.value)),
        ),
        body: SingleChildScrollView(
          // physics: const ClampingScrollPhysics(),
          child: GetBuilder<AccountSettingEditController>(
            builder: (c) {
              String hintText = '請輸入暱稱';

              if (c.type == 'email') {
                hintText = '請輸入電郵地址';
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                    controller: c.inputController,
                    hintText: hintText,
                    maxLines: 1,
                    margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
                    onChanged: (value) {
                      c.inputVal = value ?? '';
                      c.update();
                    },
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 32.w, 20.w, 0),
                    child: AppButton(
                      disabled: !c.submitAble,
                      text: c.submitting.value ? '提交中...' : '完成',
                      onPressed: () {
                        c.onSubmit();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
