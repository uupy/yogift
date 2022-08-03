import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/src/index/index_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'widgets/banners.dart';
import 'widgets/brand_list.dart';
import 'widgets/how_to_gift.dart';
import 'widgets/recommend_list.dart';
import 'widgets/top_7_days.dart';

class HomePage extends StatelessWidget implements TabBarPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: AppAssetImage(
        img: 'logo.png',
        width: 95.w,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 20.w),
      ),
      centerTitle: false,
      titleSpacing: 0,
      actions: [
        AppAssetImage(
          img: 'icon_search.png',
          width: 24.r,
          margin: EdgeInsets.only(right: 20.w),
          onTap: () {
            final indexController = Get.find<IndexController>();
            indexController.switchTabBar(2);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: const [
              HeaderBackground(),
              HomeBanners(),
            ],
          ),
          const HomeTop7Days(),
          const HomeHowToGift(),
          const HomeBrandList(),
          const HomeRecommendList(),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
