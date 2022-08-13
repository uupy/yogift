import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';

import '../set_mobile_controller.dart';

class SetMobileFirstStepForm extends StatelessWidget {
  const SetMobileFirstStepForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetMobileController>(
      id: 'FirstStepForm',
      builder: (c) {
        return Column(
          children: [
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
                    disabled: c.countdown > 0,
                    text: c.countdown > 0 ? '${c.countdown}s' : '獲取驗證碼',
                    onPressed: () {
                      c.getCode(1);
                    },
                  ),
                ),
              ],
              onChanged: (value) {
                c.verifyCode = value ?? '';
                c.update(['FirstStepForm']);
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 28.w),
              child: AppButton(
                disabled: c.verifyCode.isEmpty,
                text: c.isChecking.value ? '驗證碼校驗中...' : '驗證通過，更改手機號碼',
                onPressed: () {
                  c.checkCode();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
