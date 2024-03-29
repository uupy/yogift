import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/goods/tool_bar.dart';

import '../result_controller.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultController>(
      id: 'ToolBar',
      builder: (c) {
        return GoodsToolBar(
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
