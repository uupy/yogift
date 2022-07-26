import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/src/goods/list/list_controller.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsListController>(
      id: 'FilterBar',
      builder: (c) {
        return AppSimpleRow(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          color: AppTheme.primaryColor,
          expanded: const Text(
            'www',
            textAlign: TextAlign.right,
            style: TextStyle(),
          ),
        );
      },
    );
  }
}
