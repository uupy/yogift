import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/search/search_controller.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class SearchCategoryList extends StatelessWidget {
  const SearchCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      id: 'categoryList',
      builder: (c) {
        return SizedBox(
          height: 110.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: c.categoryList.length,
            itemBuilder: (_, i) {
              final item = c.categoryList[i];
              return Container(
                margin: i == 0
                    ? EdgeInsets.fromLTRB(20.w, 0, 6.w, 0)
                    : (i == c.categoryList.length - 1
                        ? EdgeInsets.fromLTRB(6.w, 0, 20.w, 0)
                        : EdgeInsets.symmetric(horizontal: 6.w)),
                child: Column(
                  children: [
                    AppImage(
                      width: 78.w,
                      height: 78.w,
                      radius: 18.w,
                      margin: EdgeInsets.only(bottom: 6.w),
                      url: item.classImg,
                    ),
                    Text(
                      item.className ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
