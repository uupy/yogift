import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../purchase_controller.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'AppBarTitle',
      builder: (c) {
        String name = '填寫心意卡';
        if (c.isDonation) {
          name = '確認捐贈';
        } else if (c.isGiveToSelf) {
          name = '結賬';
        }
        return Text(name);
      },
    );
  }
}
