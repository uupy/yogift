import 'package:get/get.dart';

import 'route.dart';
import 'routes.dart';

/// 路由管理
class AppRouter {
  AppRouter._internal();

  static AppRouter? _instance;

  factory AppRouter.getInstance() => _instance ??= AppRouter._internal();

  final String initialRoute = '/';

  /// 路由集合
  final List<AppRoute> _routes = routes;

  /// GetX 路由配置
  List<GetPage> get getPages =>
      _routes.where((r) => r.tabBar == null).map(routeToGetPage).toList();

  GetPage routeToGetPage(AppRoute route) {
    Transition? _transition = route.transition;
    if (_transition == null && route.tabBar == null) {
      _transition = Transition.rightToLeft;
    }
    return GetPage(
      name: route.name!,
      page: () => route.page!,
      transition: _transition,
      transitionDuration: const Duration(milliseconds: 220),
    );
  }
}

AppRouter appRouter = AppRouter.getInstance();
