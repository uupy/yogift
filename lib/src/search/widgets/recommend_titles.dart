import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/search/search_controller.dart';
import 'package:yo_gift/widgets/app_tag.dart';

class SearchRecommendTitles extends StatelessWidget {
  const SearchRecommendTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      id: 'recommendWrapper',
      init: SearchController(),
      builder: (c) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 12.w,
            children: c.recommendTitles.map((e) {
              return GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: AppTag(text: '#${e.title}'),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
