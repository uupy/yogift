import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class SenderInfoTabBar extends StatelessWidget {
  final List<String> items;
  final TabController? controller;
  final Function(int index)? onTap;

  const SenderInfoTabBar({
    Key? key,
    required this.items,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224.w,
      height: 40.w,
      margin: EdgeInsets.symmetric(horizontal: 56.w, vertical: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: TabBar(
        onTap: onTap,
        controller: controller,
        indicator: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
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
  }
}
