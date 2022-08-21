import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/src/index/charity/charity_page.dart';
import 'package:yo_gift/src/index/friends/friends_page.dart';
import 'package:yo_gift/src/index/goods/goods_page.dart';
import 'package:yo_gift/src/index/home/home_page.dart';
import 'package:yo_gift/src/index/user/user_page.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

abstract class TabBarPage implements Widget {
  PreferredSizeWidget? get appBar;
}

class TabBarRoute {
  const TabBarRoute({
    @required this.page,
    this.navBarItem,
    this.permission,
  }) : assert(page != null);

  final TabBarPage? page;
  final BottomNavigationBarItem? navBarItem;

  /// 权限控制
  final List<int>? permission;
}

final List<TabBarRoute> tabBarRoutes = [
  TabBarRoute(
    page: const HomePage(),
    navBarItem: BottomNavigationBarItem(
      label: '首頁',
      icon: AppAssetImage(
        width: 24.w,
        img: 'icon_0_0.png',
      ),
      activeIcon: AppAssetImage(
        width: 24.w,
        img: 'icon_0_1.png',
      ),
    ),
  ),
  TabBarRoute(
    page: const CharityPage(),
    navBarItem: BottomNavigationBarItem(
      label: '捐贈',
      icon: AppAssetImage(
        width: 24.w,
        img: 'icon_1_0.png',
      ),
      activeIcon: AppAssetImage(
        width: 24.w,
        img: 'icon_1_1.png',
      ),
    ),
  ),
  TabBarRoute(
    page: GoodsPage(),
    navBarItem: BottomNavigationBarItem(
      label: '搜禮物',
      icon: AppAssetImage(
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabBarRoute(
    page: FriendsPage(),
    navBarItem: BottomNavigationBarItem(
      label: '好友',
      icon: AppAssetImage(
        width: 24.w,
        img: 'icon_3_0.png',
      ),
      activeIcon: AppAssetImage(
        width: 24.w,
        img: 'icon_3_1.png',
      ),
    ),
  ),
  TabBarRoute(
    page: UserPage(),
    navBarItem: BottomNavigationBarItem(
      label: '我的',
      icon: AppAssetImage(
        width: 24.w,
        img: 'icon_4_0.png',
      ),
      activeIcon: AppAssetImage(
        width: 24.w,
        img: 'icon_4_1.png',
      ),
    ),
  ),
];
