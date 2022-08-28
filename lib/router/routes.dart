import 'package:get/get.dart';
import 'package:yo_gift/src/charity/blessing/blessing_page.dart';
import 'package:yo_gift/src/charity/detail/detail_page.dart';
import 'package:yo_gift/src/charity/pay/pay_page.dart';
import 'package:yo_gift/src/charity/pay_result/pay_result_page.dart';
import 'package:yo_gift/src/common/rich_text/rich_txt_page.dart';
import 'package:yo_gift/src/common/webview/webview_page.dart';
import 'package:yo_gift/src/friend/detail/detail_page.dart';
import 'package:yo_gift/src/goods/ask_friend/ask_friend_page.dart';
import 'package:yo_gift/src/goods/detail/detail_page.dart';
import 'package:yo_gift/src/goods/purchase/purchase_page.dart';
import 'package:yo_gift/src/index/index_page.dart';
import 'package:yo_gift/src/order/detail/detail_page.dart';
import 'package:yo_gift/src/order/donation_detail/donation_detail_page.dart';
import 'package:yo_gift/src/order/list/list_page.dart';
import 'package:yo_gift/src/order/pay_result/pay_result_page.dart';
import 'package:yo_gift/src/p2/guide/guide_page.dart';
import 'package:yo_gift/src/search/category/category_page.dart';
import 'package:yo_gift/src/search/result/result_page.dart';
import 'package:yo_gift/src/shop/all_brands/all_brands_page.dart';
import 'package:yo_gift/src/shop/detail/detail_page.dart';
import 'package:yo_gift/src/user/account_setting/account_setting_page.dart';
import 'package:yo_gift/src/user/account_setting/area/area1_page.dart';
import 'package:yo_gift/src/user/account_setting/area/area2_page.dart';
import 'package:yo_gift/src/user/account_setting/edit/edit_page.dart';
import 'package:yo_gift/src/user/donation_record/donation_record_page.dart';
import 'package:yo_gift/src/user/gift/exchange/exchange_page.dart';
import 'package:yo_gift/src/user/gift/list/list_page.dart';
import 'package:yo_gift/src/user/invite_friend/invite_friend_page.dart';
import 'package:yo_gift/src/user/login/login_page.dart';
import 'package:yo_gift/src/user/notify_setting/notify_setting_page.dart';
import 'package:yo_gift/src/user/register/register_page.dart';
import 'package:yo_gift/src/user/set_mobile/set_mobile_page.dart';
import 'package:yo_gift/src/user/set_pwd/set_pwd_page.dart';
import 'package:yo_gift/src/user/wish/wish_page.dart';

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
      name: '/pages/search/category/index', page: SearchCategoryPage()),
  const AppRoute(
      name: '/pages/charity/detail/index', page: CharityDetailPage()),
  const AppRoute(
      name: '/pages/charity/blessing/index', page: CharityBlessingPage()),
  const AppRoute(name: '/pages/charity/pay/index', page: CharityPayPage()),
  const AppRoute(
      name: '/pages/charity/pay-success/index', page: CharityPayResultPage()),
  const AppRoute(name: '/pages/wish/index/index', page: UserWishPage()),
  const AppRoute(
      name: '/pages/mine/account-setting/index', page: AccountSettingPage()),
  const AppRoute(
      name: '/pages/mine/account-setting/set-txt-val/index',
      page: AccountSettingEditPage()),
  const AppRoute(
      name: '/pages/mine/account-setting/select-area/index',
      page: AccountSettingArea1Page()),
  const AppRoute(
      name: '/pages/mine/account-setting/select-area/index2',
      page: AccountSettingArea2Page()),
  const AppRoute(
      name: '/pages/mine/user-login/set-pwd/index', page: SetPwdPage()),
  const AppRoute(
      name: '/pages/mine/user-login/set-mobile/index', page: SetMobilePage()),
  const AppRoute(
      name: '/pages/mine/notify-setting/index', page: NotifySettingPage()),
  const AppRoute(
      name: '/pages/mine/invite-friend/index', page: InviteFriendPage()),
  const AppRoute(name: '/pages/mine/order/index', page: OrderListPage()),
  const AppRoute(
      name: '/pages/mine/order/detail/index', page: OrderDetailPage()),
  const AppRoute(name: '/pages/mine/gift/mine/index', page: GiftListPage()),
  const AppRoute(
      name: '/pages/mine/gift/exchange/index', page: GiftExchangePage()),
  const AppRoute(
      name: '/pages/mine/donation-record/index', page: DonationRecordPage()),
  const AppRoute(
      name: '/pages/mine/donation-record/detail/index',
      page: DonationDetailPage()),
  const AppRoute(name: '/pages/order/pay-result/index', page: PayResultPage()),
  const AppRoute(name: '/pages/friend/detail/index', page: FriendDetailPage()),
  const AppRoute(name: '/pages/common/rich-txt/index', page: RichTxtPage()),
  const AppRoute(name: '/pages/common/webview/index', page: WebviewPage()),
];
