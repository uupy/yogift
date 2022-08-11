import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/goods/tool_bar.dart';

import '../category_controller.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchCategoryController>(
      id: 'ToolBar',
      builder: (c) {
        return GoodsToolBar(
          height: 40.w,
          buttonBorderColor: const Color(0xffcbcbcb),
          total: c.total,
          orderBy: c.orderBy,
          sendingMethod: c.sendingMethod,
          onSortChanged: c.onSortChange,
          onSendingMethodChanged: c.onSendingMethodChange,
        );
      },
    );
  }
}
