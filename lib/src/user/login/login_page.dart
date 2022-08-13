import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'login_controller.dart';
import 'widgets/login_form.dart';
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
              child: const LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
