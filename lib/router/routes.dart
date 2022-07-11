
import 'package:get/get.dart';
import 'package:yo_gift/src/index/index_page.dart';

import 'route.dart';

final List<AppRoute> routes = [
  const AppRoute(
    name: '/index',
    page: IndexPage(),
    transition: Transition.noTransition,
  ),
];
