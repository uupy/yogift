import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_tag.dart';
import 'package:yo_gift/widgets/module_title.dart';

import '../goods_controller.dart';

class SearchHistoryBar extends StatelessWidget {
  const SearchHistoryBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsController>(
      id: 'SearchHistoryBar',
      builder: (c) {
        if (c.historyList.isEmpty) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModuleTitle(
              textCn: '近期搜尋',
              textEn: 'RECENT',
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.w),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 12.w,
                children: c.historyList.map((keyword) {
                  return GestureDetector(
                    onTap: () {
                      c.onSearch(keyword);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: AppTag(
                      text: keyword,
                      color: const Color.fromRGBO(0, 0, 0, 0.9),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
