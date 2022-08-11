import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../goods_controller.dart';
import 'category_item.dart';

class SearchCategoryList extends StatelessWidget {
  const SearchCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsController>(
      id: 'CategoryList',
      builder: (c) {
        return SizedBox(
          height: 110.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: c.categoryList.length,
            itemBuilder: (_, i) {
              final item = c.categoryList[i];

              return CategoryItem(
                index: i,
                listLength: c.categoryList.length,
                imgUrl: item.classImg,
                name: item.className,
                onTap: () {
                  Get.toNamed(
                    '/pages/search/category/index',
                    parameters: {'pageType': '1', 'id': '${item.id ?? ''}'},
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
