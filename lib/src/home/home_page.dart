import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/src/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/AssetImgIcon.dart';

class HomePage extends StatelessWidget implements TabBarPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return const Center(
          child: Text('home'),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: AssetImgIcon(
        img: 'logo.png',
        width: 95.w,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 20.w),
      ),
      centerTitle: false,
      titleSpacing: 0,
      actions: [
        AssetImgIcon(
          img: 'icon_search.png',
          width: 24.r,
          margin: EdgeInsets.only(right: 20.w),
          onTap: () {},
        ),
      ],
    );
  }
}
