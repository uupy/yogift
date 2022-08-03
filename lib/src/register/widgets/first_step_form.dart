import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/register/register_controller.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/phone_prefix_select.dart';

class RegisterFirstStepForm extends StatelessWidget {
  const RegisterFirstStepForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      id: 'FirstStepForm',
      builder: (c) {
        return Column(
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
                      c.update(['FirstStepForm']);
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
                      c.update(['FirstStepForm']);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.w),
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
                c.update(['FirstStepForm']);
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 28.w),
              child: AppButton(
                disabled: !c.nextStepAble,
                text: '下一步',
                onPressed: () {
                  c.step(2);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
