import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/user_favorites.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods/goods_sending_tag.dart';
import 'package:yo_gift/widgets/header_background.dart';

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
        title: const Text('我的願望清單'),
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
              final buyPrice = item.buyPrice;

              return AppCard(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildImgContainer(item.cCoverImg, item.sendingMethod),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.w,
                                child: Text(
                                  item.giftName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
                                child: Text(
                                  item.bussinessName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: const Color.fromRGBO(0, 0, 0, .4),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.w),
                              Text(
                                '\$$buyPrice',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildFooterItem(
                          text: '拜託',
                          icon: 'icon_please.png',
                          background: const Color(0xfffffdeb),
                        ),
                        buildFooterItem(
                          text: '購買',
                          icon: 'icon_shopping_bag.png',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildImgContainer(String? url, int? sendingMethod) {
    return Stack(
      children: [
        AppImage(
          width: 90.w,
          height: 90.w,
          url: url,
          color: Colors.white,
          radius: 12.r,
          border: Border.all(
            width: 0.5,
            color: const Color(0xffe6e6e6),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GoodsSendingTag(
            method: sendingMethod ?? 1,
          ),
        ),
      ],
    );
  }

  Widget buildFooterItem({
    String? text,
    String? icon,
    Color? background,
    Function()? onTap,
  }) {
    return Container(
      width: 96.w,
      height: 32.w,
      margin: EdgeInsets.only(left: 10.w),
      child: AppButton(
        backgroundColor: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssetImage(
              img: icon,
              width: 16.w,
              margin: EdgeInsets.only(right: 5.w),
            ),
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
