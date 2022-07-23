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
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.w,
                  ),
                  textCn: t.className,
                  textEn: t.classNameEn,
                ),
                Container(
                  height: 115.w,
                  margin: EdgeInsets.only(bottom: 5.w),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final item = t.childModel![index];
                      return AppCard(
                        width: 105.w,
                        height: 105.w,
                        padding: EdgeInsets.zero,
                        margin: getItemMargin(index, itemCount - 1),
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

  EdgeInsetsGeometry? getItemMargin(int index, int last) {
    if (index == 0) {
      return EdgeInsets.fromLTRB(20.w, 5.w, 6.w, 5.w);
    } else if (index == last) {
      return EdgeInsets.fromLTRB(6.w, 5.w, 20.w, 5.w);
    }
    return EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.w);
  }
}
