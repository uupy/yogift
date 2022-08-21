import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/widgets/menu_row/menu_item.dart';

class UserController extends GetxController {
  final menus1 = [
    MenuItem(
      icon: 'icon_mine_order.png',
      label: '我購買的禮物',
      path: '/pages/mine/order/index',
    ),
    MenuItem(icon: 'icon_mine_gift.png', label: '我收到的禮物'),
    MenuItem(icon: 'icon_contribute.png', label: '捐贈記錄'),
  ];
  final menus2 = [
    MenuItem(
      icon: 'icon_mine_invitation.png',
      label: '邀請朋友即時有禮',
      path: '/pages/mine/invite-friend/index',
    ),
  ];
  final menus3 = [
    MenuItem(
      icon: 'icon_mine_notify.png',
      label: '通知設定',
      path: '/pages/mine/notify-setting/index',
    ),
    MenuItem(
      icon: 'icon_mine_question.png',
      label: '常見問題',
      path: '/pages/common/rich-txt/index?type=help',
    ),
    MenuItem(
      icon: 'icon_mine_contact.png',
      label: '聯絡我們',
      key: 'contact',
    ),
    MenuItem(
      icon: 'icon_mine_terms.png',
      label: '條款及細則',
      path: '/pages/common/rich-txt/index?type=clause',
    ),
  ];

  UserInfoVo? userInfo = app.userInfo;

  bool get isLogged {
    return userInfo?.id?.isNotEmpty ?? false;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    await app.updateUserInfo();
    userInfo = app.userInfo;
    update(['UserHeaderInfo', 'UserAppBarAction']);
  }
}
