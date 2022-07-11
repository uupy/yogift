import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  /// 切换导航tab
  void switchTabBar(int index) async {
    currentIndex = index;
    pageController?.jumpToPage(index);
    update();
  }
}
