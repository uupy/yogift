import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/phone_prefix_select.dart';

import 'login_controller.dart';
import 'widgets/tab_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<String> _tabItems = ['密碼登入', '短信登入'];
  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登入YO！GIFT'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const AppAssetImage(
              img: 'bg_top2.png',
            ),
            LoginTabBar(
              controller: _tabController,
              items: _tabItems,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40.w),
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
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
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.w),
              if (c.loginType == 0)
                const FormItem(
                  label: '密码',
                  hintText: '请输入密码',
                  obscureText: true,
                ),
              if (c.loginType == 1)
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
                        text: '獲取驗證碼',
                      ),
                    ),
                  ],
                ),
              Container(
                margin: EdgeInsets.only(top: 28.w),
                child: AppButton(
                  disabled: true,
                  text: c.submitting.value ? '登入中...' : '登入',
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
