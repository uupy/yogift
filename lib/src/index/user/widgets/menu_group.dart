import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_card.dart';

import '../user_controller.dart';
import 'menu_row.dart';

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
              } else if (item.key?.isNotEmpty ?? false) {
                showModalBottomSheet<int>(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                        height: 200, //这里调整高度即可，建议按照屏幕高度比例来计算
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    EdgeInsets.fromLTRB(30.w, 10.w, 10.w, 10.w),
                                child: const Text(
                                  "您可通過以下方式聯繫：",
                                  textAlign: TextAlign.start,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    // margin: EdgeInsets.all(10.w),
                                    child: Column(
                                      children: [
                                        AppAssetImage(
                                          width: 44.w,
                                          height: 44.w,
                                          margin: EdgeInsets.fromLTRB(
                                              50.w, 30.w, 30.w, 10.w),
                                          img: 'icon_email.png',
                                        ),
                                        Text(
                                          "郵件",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    // margin: EdgeInsets.all(10.w),
                                    child: Column(
                                      children: [
                                        AppAssetImage(
                                          width: 44.w,
                                          height: 44.w,
                                          margin: EdgeInsets.fromLTRB(
                                              50.w, 30.w, 30.w, 10.w),
                                          img: 'icon_online.png',
                                        ),
                                        Text(
                                          "在線客服",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  },
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
