import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/search/result/result_controller.dart';
import 'package:yo_gift/widgets/animated_button.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'tool_bar_filter.dart';
import 'tool_bar_sort.dart';

class ToolBar extends StatelessWidget {
  ToolBar({Key? key}) : super(key: key);

  final sortController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultController>(
      id: 'ToolBar',
      builder: (c) {
        return Container(
          margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.w),
          child: Row(
            children: [
              ToolBarSort(
                value: c.orderby,
                onChanged: (index) {
                  final idx = index + 1;
                  if (c.orderby != idx) {
                    c.orderby = idx;
                  } else {
                    c.orderby = null;
                  }
                  c.onSortChange(c.orderby);
                },
              ),
              SizedBox(width: 6.w),
              ToolBarFilter(
                value: c.sendingmethod,
                onChanged: (index) {
                  final idx = index + 1;
                  if (c.sendingmethod != idx) {
                    c.sendingmethod = idx;
                  } else {
                    c.sendingmethod = null;
                  }
                  c.onSortChange(c.sendingmethod);
                },
              ),
              Expanded(
                child: Text(
                  '已顯示：${c.total}個禮物',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildButton({String? text, String? icon, Function()? onPressed}) {
    return AnimatedButton(
      onPressed: onPressed,
      color: Colors.white,
      borderColor: Colors.white,
      width: 78.w,
      height: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssetImage(
            width: 16.w,
            img: icon,
          ),
          Text(
            text ?? '',
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
