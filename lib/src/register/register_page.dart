import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';

import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('註冊YO！GIFT'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const AppAssetImage(
              img: 'img_gift.png',
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30.w, top: 32.w),
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return GetBuilder<RegisterController>(
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
                    hintText: '請選擇',
                    readOnly: true,
                  ),
                  const Expanded(
                    child: FormItem(
                      label: '手機號碼',
                      hintText: '請輸入手機號碼',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.w),
              FormItem(
                label: '驗證碼',
                hintText: '請輸入驗證碼',
                padding: EdgeInsets.only(left: 10.w),
                actions: [
                  Container(
                    margin: EdgeInsets.all(6.w),
                    child: const AppButton(
                      round: false,
                      disabled: true,
                      child: Text('獲取驗證碼'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 28.w),
                child: const AppButton(
                  child: Text('下一步'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
