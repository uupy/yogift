import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/common/custom_dialog/custom_dialog.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/src/index/user/user_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class IndexController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// PageView Controller
  PageController? pageController;

  /// current tab index
  int currentIndex = 0;

  /// Page view
  List<Widget> pages = [];

  /// own routes
  List<TabBarRoute> ownRoutes = [];

  /// navBarItems
  List<BottomNavigationBarItem> navBarItems = [];

  /// current tabBar route
  TabBarRoute? get currentRoute => ownRoutes[currentIndex];

  @override
  void onInit() async {
    initIndex();
    super.onInit();
  }

  Future initIndex() async {
    pageController ??= PageController(initialPage: currentIndex);
    await initPermission();
  }

  Future initPermission() async {
    pages = [];
    navBarItems = [];
    for (var route in tabBarRoutes) {
      ownRoutes.add(route);
      pages.add(route.page!);
      navBarItems.add(route.navBarItem ??
          const BottomNavigationBarItem(
            icon: Icon(IconFont.icon_home),
          ));
    }
    update();
  }

  /// 广告弹窗
  Future showAdDialog() async {
    final now = DateTime.now();
    final lastTimestamp = await lastOpenAdTime.get();
    final appController = Get.find<AppController>();
    final ads = appController.config?.popupWindow ?? [];

    bool shouldShow = lastTimestamp == null;

    if (lastTimestamp != null) {
      final lastTime = DateTime.fromMillisecondsSinceEpoch(lastTimestamp);
      final inDays = now.difference(lastTime).inDays;
      final inHours = now.difference(lastTime).inHours;
      shouldShow = inDays > 0 && inHours > 2;
    }

    if (ads.isNotEmpty && shouldShow) {
      final ad = ads.last;
      final nowTimestamp = now.millisecondsSinceEpoch;

      await lastOpenAdTime.set(nowTimestamp);
      await Future.delayed(const Duration(milliseconds: 500));

      return await showAnimationDialog<bool>(
        context: Get.context!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage(
              crop: false,
              color: Colors.transparent,
              width: Get.width - 40.w,
              fit: BoxFit.fitWidth,
              withOutDecoration: true,
              url: ad.bannerImg,
              onTap: () async {
                app.navToByLinkType(
                  link: ad.link,
                  linkType: ad.linkType ?? 0,
                  isDialog: true,
                );
              },
            ),
            AppAssetImage(
              width: 24.w,
              margin: EdgeInsets.only(top: 10.w),
              img: 'icon_close2.png',
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }

  /// 切换导航tab
  void switchTabBar(int index) async {
    currentIndex = index;
    pageController?.jumpToPage(index);
    if (index == 4) {
      final userController = Get.find<UserController>();
      userController.init();
    }
    update();
  }
}
