import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/src/donate/donate_page.dart';
import 'package:yo_gift/src/friends/friends_page.dart';
import 'package:yo_gift/src/search/search_page.dart';
import 'package:yo_gift/widgets/AssetImgIcon.dart';

import 'package:yo_gift/src/home/home_page.dart';
import 'package:yo_gift/src/user/user_page.dart';

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
      icon: AssetImgIcon(
        width: 24.w,
        img: 'icon_0_0.png',
      ),
      activeIcon: AssetImgIcon(
        width: 24.w,
        img: 'icon_0_1.png',
      ),
    ),
  ),
  TabBarRoute(
    page: const DonatePage(),
    navBarItem: BottomNavigationBarItem(
      label: '捐贈',
      icon: AssetImgIcon(
        width: 24.w,
        img: 'icon_1_0.png',
      ),
      activeIcon: AssetImgIcon(
        width: 24.w,
        img: 'icon_1_1.png',
      ),
    ),
  ),
  TabBarRoute(
    page: const SearchPage(),
    navBarItem: BottomNavigationBarItem(
      label: '搜禮物',
      icon: AssetImgIcon(
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabBarRoute(
    page: const FriendsPage(),
    navBarItem: BottomNavigationBarItem(
      label: '好友',
      icon: AssetImgIcon(
        width: 24.w,
        img: 'icon_3_0.png',
      ),
      activeIcon: AssetImgIcon(
        width: 24.w,
        img: 'icon_3_1.png',
      ),
    ),
  ),
  TabBarRoute(
    page: const UserPage(),
    navBarItem: BottomNavigationBarItem(
      label: '我的',
      icon: AssetImgIcon(
        width: 24.w,
        img: 'icon_4_0.png',
      ),
      activeIcon: AssetImgIcon(
        width: 24.w,
        img: 'icon_4_1.png',
      ),
    ),
  ),
];
