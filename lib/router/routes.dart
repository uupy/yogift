import 'package:get/get.dart';
import 'package:yo_gift/src/index/index_page.dart';
import 'package:yo_gift/src/login/login_page.dart';
import 'package:yo_gift/src/register/register_page.dart';

import 'route.dart';

final List<AppRoute> routes = [
  const AppRoute(
    name: '/index',
    page: IndexPage(),
    transition: Transition.noTransition,
  ),
  const AppRoute(
    name: '/login',
    page: LoginPage(),
  ),
  const AppRoute(
    name: '/register',
    page: RegisterPage(),
  ),
];
