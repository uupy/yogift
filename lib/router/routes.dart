import 'package:get/get.dart';
import 'package:yo_gift/src/brand/index/index_page.dart';
import 'package:yo_gift/src/clause/clause_page.dart';
import 'package:yo_gift/src/goods/detail/detail_page.dart';
import 'package:yo_gift/src/index/index_page.dart';
import 'package:yo_gift/src/login/login_page.dart';
import 'package:yo_gift/src/p2/guide/guide_page.dart';
import 'package:yo_gift/src/problem/problem_page.dart';
import 'package:yo_gift/src/register/register_page.dart';

import 'route.dart';

/// 路由名称 [name] , 保持和 h5 页面路径一致
/// 因为会有一些配置跳转（比如：banner点击，弹窗跳转等）
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
  const AppRoute(name: '/p2/guide/index', page: P2GuidePage()),
  const AppRoute(
    name: '/goods/detail',
    page: GoodsDetailPage(),
  ),
  const AppRoute(
    name: '/brand-index',
    page: BrandIndexPage(),
  ),
  const AppRoute(name: '/clause', page: ClausePage()),
  const AppRoute(name: '/problem', page: ProblemPage())
];
