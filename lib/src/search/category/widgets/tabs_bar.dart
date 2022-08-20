import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_theme.dart';

import '../category_controller.dart';

class GoodsCategoryTabsBar extends StatelessWidget {
  final TabController? controller;

  const GoodsCategoryTabsBar({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCategoryController>(
      id: 'CategoryTabsBar',
      builder: (c) {
        final tabs = c.categoryList;

        if (tabs.isEmpty) {
          return Container();
        }

        return DefaultTabController(
          length: tabs.length,
          initialIndex: c.tabIndex,
          child: TabBar(
            onTap: c.onCategoryChanged,
            controller: controller,
            isScrollable: true,
            indicator: const BoxDecoration(),
            labelColor: const Color.fromRGBO(0, 0, 0, 0.9),
            labelStyle: TextStyle(
              fontSize: 14.sp,
            ),
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.6),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            tabs: tabs.asMap().keys.map(
              (index) {
                final item = c.categoryList[index];
                final isActive = index == c.tabIndex;
                final color = isActive ? Colors.white : AppTheme.primaryColor;
                BorderRadiusGeometry? borderRadius;

                if (isActive) {
                  borderRadius = BorderRadius.only(
                    topRight: Radius.circular(8.w),
                    topLeft: Radius.circular(8.w),
                  );
                } else if (index == c.tabIndex + 1) {
                  borderRadius = BorderRadius.only(
                    bottomLeft: Radius.circular(8.w),
                  );
                } else if (index == c.tabIndex - 1) {
                  borderRadius = BorderRadius.only(
                    bottomRight: Radius.circular(8.w),
                  );
                }

                return Tab(
                  child: Stack(
                    children: [
                      if (isActive)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 18.w,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: borderRadius,
                        ),
                        child: Center(
                          child: Text(item.className ?? ''),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
