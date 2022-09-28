import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/user_favorites.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'widgets/list_item.dart';
import 'wish_controller.dart';

class UserWishPage extends StatefulWidget {
  const UserWishPage({Key? key}) : super(key: key);

  @override
  _UserWishPageState createState() => _UserWishPageState();
}

class _UserWishPageState extends State<UserWishPage> {
  final controller = Get.put(UserWishController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.friendName ?? '我'}的願望清單'),
      ),
      body: Stack(
        children: [
          HeaderBackground(
            height: 120.w,
            radius: 100.w,
          ),
          AppListView<UserFavoritesItemVo>(
            emptyPadding: EdgeInsets.fromLTRB(50.w, 100.w, 50.w, 0),
            waterDropColor: const Color.fromRGBO(0, 0, 0, 0.26),
            fetch: controller.queryList,
            controller: controller.listController,
            colCount: 1,
            itemBuilder: (item, index, list) {
              return AppCard(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.w),
                onTap: () {
                  Get.toNamed('/pages/goods/detail/index', parameters: {
                    'id': item.gGuid ?? '',
                  });
                },
                child: WishListItem(
                  item: item,
                  isFriend: controller.isFriend,
                  onRemoved: () {
                    controller.listController.setState?.call(() {
                      controller.listController.list.remove(item);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
