import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../detail_controller.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailController>(
      id: 'AppBarTitle',
      builder: (c) {
        return Text(c.detail?.bussinessName ?? '');
      },
    );
  }
}
