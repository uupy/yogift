import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/text_form_item.dart';

import '../set_pwd_controller.dart';

class SetPwdSecondStepForm extends StatelessWidget {
  const SetPwdSecondStepForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetPwdController>(
      id: 'SecondStepForm',
      builder: (c) {
        return Form(
          key: c.updateFormKey,
          child: Column(
            children: [
              FormItem(
                label: '密碼',
                hintText: '請輸入密碼',
                obscureText: true,
                onChanged: (value) {
                  c.formData2.password = value;
                  c.update(['SecondStepForm']);
                },
              ),
              SizedBox(height: 12.w),
              TextFormItem(
                label: '確認密碼',
                hintText: '請再次輸入密碼',
                obscureText: true,
                onChanged: (value) {
                  c.confirmPassword = value;
                  c.formKey.currentState?.validate();
                  c.update(['SecondStepForm']);
                },
                validator: (value) {
                  final _value = value ?? '';
                  final pwd = c.formData2.password ?? '';
                  if (_value.isNotEmpty && _value != pwd) {
                    return '兩次密碼輸入不一致';
                  }
                  if (_value.isEmpty) {
                    return '請輸入確認密碼';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.w),
              Container(
                margin: EdgeInsets.only(top: 28.w),
                child: AppButton(
                  disabled: !c.submitAble,
                  text: c.submitting.value ? '提交中...' : '確認修改密碼',
                  onPressed: () {
                    c.onSubmit();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
