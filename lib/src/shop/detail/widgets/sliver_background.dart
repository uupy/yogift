import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import '../detail_controller.dart';

class SliverBackground extends StatelessWidget {
  const SliverBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailController>(
      id: 'SliverBackground',
      builder: (c) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppImage(
              width: 100.w,
              height: 100.w,
              radius: 100.w,
              border: Border.all(
                color: const Color(0xfff5f5f5),
              ),
              alignment: Alignment.bottomCenter,
              url: c.detail?.bussinessImg,
            ),
          ],
        );
      },
    );
  }
}
