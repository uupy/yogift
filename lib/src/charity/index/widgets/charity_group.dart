import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/charity/index/index_controller.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/module_title.dart';

class CharityListGroup extends StatelessWidget {
  const CharityListGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GetBuilder<CharityIndexController>(
        init: CharityIndexController(),
        builder: (c) {
          List<Widget> children = [];

          for (final t in c.list) {
            if (t.childModel?.isNotEmpty ?? false) {
              final itemCount = t.childModel?.length ?? 0;
              children.addAll([
                ModuleTitle(
                  textCn: t.className,
                  textEn: t.classNameEn,
                ),
                Container(
                  height: 105.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final item = t.childModel![index];
                      return AppCard(
                        width: 105.w,
                        height: 105.w,
                        padding: EdgeInsets.zero,
                        margin: index == 0
                            ? EdgeInsets.fromLTRB(20.w, 0, 6.w, 0)
                            : (index == itemCount - 1
                                ? EdgeInsets.fromLTRB(6.w, 0, 20.w, 0)
                                : EdgeInsets.symmetric(horizontal: 6.w)),
                        child: AppImage(
                          url: item.charityImg,
                          radius: 20.r,
                        ),
                      );
                    },
                  ),
                ),
              ]);
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        },
      ),
    );
  }
}
