import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/menu_row/menu_row.dart';

import 'area_controller.dart';

class AccountSettingArea1Page extends StatelessWidget {
  const AccountSettingArea1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設置地區'),
      ),
      body: GetBuilder<AccountSettingAreaController>(
        id: 'Area1Page',
        init: AccountSettingAreaController(),
        builder: (c) {
          final list = c.areaList1;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: list.length,
            itemBuilder: (_, index) {
              final item = list[index];
              return MenuRow(
                label: item.title,
                onTap: () {
                  c.parent = item;
                  c.fetchData(item.id!);
                  Get.toNamed('/pages/mine/account-setting/select-area/index2')
                      ?.then((result) {
                    if (result == true) {
                      Get.back(result: true);
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
