import 'package:get/get.dart';
import 'package:yo_gift/src/charity/detail/detail_page.dart';
import 'package:yo_gift/src/clause/clause_page.dart';
import 'package:yo_gift/src/goods/ask_friend/ask_friend_page.dart';
import 'package:yo_gift/src/goods/detail/detail_page.dart';
import 'package:yo_gift/src/goods/purchase/purchase_page.dart';
import 'package:yo_gift/src/index/index_page.dart';
import 'package:yo_gift/src/login/login_page.dart';
import 'package:yo_gift/src/p2/guide/guide_page.dart';
import 'package:yo_gift/src/problem/problem_page.dart';
import 'package:yo_gift/src/register/register_page.dart';
import 'package:yo_gift/src/search/result/result_page.dart';
import 'package:yo_gift/src/shop/all_brands/all_brands_page.dart';
import 'package:yo_gift/src/shop/detail/detail_page.dart';

import 'route.dart';

/// 路由名称 [name] , 保持和 h5 页面路径一致
/// 因为会有一些配置跳转（比如：banner点击，弹窗跳转等）
final List<AppRoute> routes = [
  const AppRoute(
    name: '/index',
    page: IndexPage(),
    transition: Transition.noTransition,
  ),
  const AppRoute(name: '/login', page: LoginPage()),
  const AppRoute(name: '/register', page: RegisterPage()),
  const AppRoute(name: '/p2/guide/index', page: P2GuidePage()),
  const AppRoute(name: '/pages/shop/all-brands/index', page: AllBrandsPage()),
  const AppRoute(name: '/pages/shop/detail/index', page: ShopDetailPage()),
  const AppRoute(name: '/pages/goods/detail/index', page: GoodsDetailPage()),
  const AppRoute(name: '/pages/goods/ask-friend/index', page: AskFriendPage()),
  const AppRoute(name: '/pages/goods/purchase/index', page: PurchasePage()),
  const AppRoute(name: '/pages/search/result/index', page: SearchResultPage()),
  const AppRoute(
      name: '/pages/charity/detail/index', page: CharityDetailPage()),
  const AppRoute(name: '/clause', page: ClausePage()),
  const AppRoute(name: '/problem', page: ProblemPage())
];
