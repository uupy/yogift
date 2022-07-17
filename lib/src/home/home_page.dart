import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/src/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/AssetImgIcon.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/module_title.dart';

import 'widgets/banners.dart';

class HomePage extends StatelessWidget implements TabBarPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            children: [
              const HeaderBackground(),
              GetBuilder<HomeController>(
                init: HomeController(),
                builder: (c) {
                  return HomeBanners(
                    items: c.banners,
                    currentBannerIndex: c.currentBannerIndex,
                    onChanged: (index) {
                      c.onBannerChanged(index);
                    },
                  );
                },
              ),
            ],
          ),
          const ModuleTitle(
            textCn: '7天人氣排行榜',
            textEn: 'RANK',
            suffixAssetImg: 'icon_label_1.png',
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10.h, 0, 30.h),
            color: const Color(0xfffefdee),
            child: Column(
              children: [
                const ModuleTitle(
                  textCn: '如何即時送禮？',
                  textEn: 'HOW TO GIFT？',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Image.asset('lib/assets/images/img_guide.png'),
                ),
                Container(
                  width: 160.w,
                  margin: EdgeInsets.only(top: 30.h),
                  child: AppButton(
                    text: '查看使用流程',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const ModuleTitle(
            textCn: '瀏覽品牌',
            textEn: 'BROWSE BRANDS',
            suffixAssetImg: 'icon_label_2.png',
          ),
          const ModuleTitle(
            textCn: '推薦禮物',
            textEn: 'RECOMMEND',
            suffixAssetImg: 'icon_label_3.png',
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: AssetImgIcon(
        img: 'logo.png',
        width: 95.w,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 20.w),
      ),
      centerTitle: false,
      titleSpacing: 0,
      actions: [
        AssetImgIcon(
          img: 'icon_search.png',
          width: 24.r,
          margin: EdgeInsets.only(right: 20.w),
          onTap: () {},
        ),
      ],
    );
  }
}
