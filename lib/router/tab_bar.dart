import 'package:yo_gift/src/home/home_page.dart';
import 'package:flutter/material.dart';

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
  const TabBarRoute(
    page: HomePage(),
  ),
];
