import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/src/login/login_controller.dart';

class GoodsDetailTabsBar extends StatelessWidget {
  final TabController? controller;
  final List<String> items;

  const GoodsDetailTabsBar({
    Key? key,
    this.controller,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (c) {
        return Container(
          height: 40.w,
          margin: EdgeInsets.symmetric(vertical: 32.w),
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          decoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(
              width: 1,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            )),
          ),
          child: TabBar(
            controller: controller,
            indicatorColor: AppTheme.primaryColor,
            labelColor: const Color.fromRGBO(0, 0, 0, 0.9),
            labelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.6),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            tabs: items.map(
              (name) {
                return Tab(
                  child: Text(name),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
