import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/register/register_controller.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/text_form_item.dart';

class RegisterSecondStepForm extends StatelessWidget {
  const RegisterSecondStepForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      id: 'SecondStepForm',
      builder: (c) {
        return Form(
          key: c.formKey,
          child: Column(
            children: [
              FormItem(
                label: '密碼',
                hintText: '請輸入密碼',
                obscureText: true,
                onChanged: (value) {
                  c.formData.password = value;
                  if (c.confirmPassword?.isNotEmpty ?? false) {
                    c.formKey.currentState?.validate();
                  }
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
                  final pwd = c.formData.password ?? '';
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
              FormItem(
                label: '推薦碼（選填）',
                hintText: '請輸入推薦碼',
                onChanged: (value) {
                  c.formData.recommendationcode = value;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 28.w),
                child: AppButton(
                  disabled: !c.submitAble,
                  text: c.submitting.value ? '提交中...' : '註冊',
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
