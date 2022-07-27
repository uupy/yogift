import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/user/user_controller.dart';
import 'package:yo_gift/src/user/widgets/menu_row.dart';
import 'package:yo_gift/widgets/app_card.dart';

class UserMenuGroup extends StatelessWidget {
  final List<UserMenuItem> menus;

  const UserMenuGroup({
    Key? key,
    required this.menus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: double.maxFinite,
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
      blurRadius: 2.r,
      child: Column(
        children: menus.asMap().keys.map((index) {
          final item = menus[index];
          return MenuRow(
            icon: item.icon,
            label: item.label,
            showBottomBorder: index != menus.length - 1,
            onTap: () {
              if (item.path?.isNotEmpty ?? false) {
                Get.toNamed(item.path!);
              } else {
                //弹出
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        SimpleDialogOption(
                          child: const Text('选项 1'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text('选项 2'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                ).then((val) {
                  // if (kDebugMode) {
                  //   // print(val);
                  // }
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
