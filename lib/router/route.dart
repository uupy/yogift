import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoute {
  /// 路由别名
  final String? name;

  /// 页面
  final Widget? page;

  /// transition
  final Transition? transition;

  /// tabBar配置
  final BottomNavigationBarItem? tabBar;

  /// 子项（占坑）
  final List<AppRoute>? children;

  const AppRoute({
    @required this.name,
    @required this.page,
    this.transition,
    this.tabBar,
    this.children,
  }) : assert(name != null && page != null);
}
