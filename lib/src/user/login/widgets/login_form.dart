import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/phone_prefix_select.dart';

import '../login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (c) {
        return Form(
          key: c.formKey,
          child: Column(
            children: [
              Row(
                children: [
                  FormItem(
                    width: 96.w,
                    margin: EdgeInsets.only(right: 8.w),
                    label: '區號',
                    customInput: PhonePrefixSelect(
                      onChanged: (value) {
                        c.formData.phoneprefix = value;
                        c.update();
                      },
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '手機號碼',
                      hintText: '請輸入手機號碼',
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        c.formData.phone = value;
                        c.update();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.w),
              if (c.loginType == 0)
                FormItem(
                  label: '密码',
                  hintText: '请输入密码',
                  obscureText: true,
                  onChanged: (value) {
                    c.formData.password = value ?? '';
                    c.update();
                  },
                ),
              if (c.loginType == 1)
                FormItem(
                  label: '驗證碼',
                  hintText: '請輸入驗證碼',
                  padding: EdgeInsets.only(left: 10.w),
                  keyboardType: TextInputType.number,
                  actions: [
                    Container(
                      margin: EdgeInsets.all(6.w),
                      child: AppButton(
                        round: false,
                        fixedSize: Size(84.w, 32.w),
                        fontSize: 12.sp,
                        disabled: !c.getCodeAble,
                        text: c.countdown > 0 ? '${c.countdown}s' : '獲取驗證碼',
                        onPressed: () {
                          c.getCode();
                        },
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    c.formData.code = value;
                    c.update();
                  },
                ),
              Container(
                margin: EdgeInsets.only(top: 28.w),
                child: AppButton(
                  disabled: !c.submitAble,
                  text: c.submitting.value ? '登入中...' : '登入',
                  onPressed: () {
                    c.onSubmit();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14.w),
                child: AppButton(
                  backgroundColor: const Color(0xfffffdeb),
                  onPressed: () {
                    Get.toNamed('/register');
                  },
                  child: const Text(
                    '註冊',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.9),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14.w),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '無法登入？',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
