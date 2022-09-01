import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/header_background.dart';

import '../detail_controller.dart';

class HeaderBackdrop extends StatelessWidget {
  const HeaderBackdrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailController>(
      id: 'HeaderBackdrop',
      builder: (c) {
        return HeaderBackground(
          color: Colors.white,
          child: AppImage(
            url: c.detail?.bussinessImgBg,
          ),
        );
      },
    );
  }
}
