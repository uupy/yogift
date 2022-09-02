import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/module_title.dart';

import '../charity_controller.dart';

class CharityListGroup extends StatelessWidget {
  const CharityListGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GetBuilder<CharityController>(
        init: CharityController(),
        builder: (c) {
          List<Widget> children = [];

          for (final t in c.list) {
            final items = t.childModel ?? [];
            if (items.isNotEmpty) {
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
                  margin: EdgeInsets.only(left: 14.w, bottom: 5.w),
                  child: Wrap(
                    children: items.map((item) {
                      return AppCard(
                        width: 105.w,
                        height: 105.w,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.all(6.w),
                        child: AppImage(
                          url: item.charityImg,
                          radius: 20.r,
                          onTap: () {
                            Get.toNamed('/pages/charity/detail/index',
                                parameters: {'id': item.cGuid!});
                          },
                        ),
                      );
                    }).toList(),
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
