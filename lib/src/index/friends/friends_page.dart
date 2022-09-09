import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/friends_list.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/app_row.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'friends_controller.dart';

class FriendsPage extends StatelessWidget implements TabBarPage {
  FriendsPage({Key? key}) : super(key: key);
  final controller = Get.put(FriendsController());

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('好友'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppListView<FriendVo>(
      fetch: controller.queryList,
      controller: controller.listController,
      colCount: 1,
      emptyPadding: EdgeInsets.fromLTRB(50.w, 60.w, 50.w, 0),
      itemBuilder: (item, index, list) {
        return AppRow(
          onTap: () {
            Get.toNamed('/pages/friend/detail/index', parameters: {
              'friendId': '${item.friendId}',
              'friendName': '${item.friendNickName}',
            });
          },
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.symmetric(vertical: 16.w),
          border: const Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(230, 230, 230, 0.3),
            ),
          ),
          prefix: [
            AppImage(
              width: 60.w,
              height: 60.w,
              radius: 15.w,
              color: Colors.transparent,
              margin: EdgeInsets.only(right: 12.w),
              url: item.friendHeadSrc,
            ),
          ],
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.friendNickName ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              AppSimpleRow(
                margin: EdgeInsets.only(top: 6.w),
                children: [
                  AppAssetImage(
                    width: 20.w,
                    margin: EdgeInsets.only(right: 4.w),
                    img: 'icon_gift1.png',
                  ),
                  Text(
                    item.msgContent ?? '',
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          suffix: [
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.msgCreateTime ?? '',
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.26),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppSimpleRow(
                    margin: EdgeInsets.only(top: 11.w),
                    children: [
                      Text(
                        '好感度',
                        style: TextStyle(
                          color: const Color(0xffff8d00),
                          fontSize: 14.sp,
                        ),
                      ),
                      AppAssetImage(
                        width: 20.w,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        img: 'icon_gift1.png',
                      ),
                      Text(
                        '${item.giveN ?? 0}',
                        style: TextStyle(
                          color: const Color(0xffff8d00),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
