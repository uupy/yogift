import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/animated_button.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/menu_row/menu_row.dart';

import 'area_controller.dart';

class AccountSettingArea2Page extends StatelessWidget {
  const AccountSettingArea2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設置地區'),
        actions: [
          Container(
            width: 78.w,
            margin: EdgeInsets.fromLTRB(0, 10.w, 20.w, 10.w),
            child: GetBuilder<AccountSettingAreaController>(
              id: 'Area2Action',
              builder: (c) {
                if (c.selected == null) {
                  return Container();
                }
                return AnimatedButton(
                  text: '完成',
                  color: Colors.white,
                  borderColor: Colors.white,
                  onPressed: () {
                    c.onSubmit();
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: GetBuilder<AccountSettingAreaController>(
        id: 'Area2Page',
        builder: (c) {
          final list = c.areaList2;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: list.length + 1,
            itemBuilder: (_, index) {
              if (index == 0) {
                return MenuRow(
                  icon: 'icon_address.png',
                  label: c.parent?.title,
                  arrow: false,
                );
              }

              final item = list[index - 1];

              return MenuRow(
                label: item.title,
                arrow: false,
                suffix: c.selected?.id == item.id
                    ? AppAssetImage(
                        width: 16.w,
                        img: 'icon_checked.png',
                      )
                    : null,
                onTap: () {
                  c.selected = item;
                  c.update(['Area2Page', 'Area2Action']);
                },
              );
            },
          );
        },
      ),
    );
  }
}
