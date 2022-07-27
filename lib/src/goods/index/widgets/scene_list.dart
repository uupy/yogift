import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/index/index_controller.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class SearchSceneList extends StatelessWidget {
  const SearchSceneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsIndexController>(
      id: 'sceneList',
      builder: (c) {
        return SizedBox(
          height: 110.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: c.sceneList.length,
            itemBuilder: (_, i) {
              final item = c.sceneList[i];
              return Container(
                margin: i == 0
                    ? EdgeInsets.fromLTRB(20.w, 0, 6.w, 0)
                    : (i == c.sceneList.length - 1
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
