import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class GoodsDetailTabsBar extends StatelessWidget {
  final List<String> items;
  final TabController? controller;
  final Function(int)? onTap;

  const GoodsDetailTabsBar({
    Key? key,
    required this.items,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.w,
      margin: EdgeInsets.only(top: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.w),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color.fromRGBO(230, 230, 230, 0.5),
          ),
        ),
      ),
      child: TabBar(
        onTap: onTap,
        controller: controller,
        indicatorColor: AppTheme.primaryColor,
        indicatorWeight: 5.w,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: const Color.fromRGBO(0, 0, 0, 0.9),
        labelStyle: TextStyle(
          fontSize: 14.sp,
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
  }
}
