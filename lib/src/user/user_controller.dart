import 'package:get/get.dart';

class UserMenuItem {
  final String? icon;
  final String? label;
  final String? path;

  UserMenuItem({this.icon, this.label, this.path});
}

class UserController extends GetxController {
  final List<UserMenuItem> menus1 = [
    UserMenuItem(
      icon: 'icon_mine_order.png',
      label: '我購買的禮物',
    ),
    UserMenuItem(
      icon: 'icon_mine_gift.png',
      label: '我收到的禮物',
    ),
    UserMenuItem(
      icon: 'icon_contribute.png',
      label: '捐贈記錄',
    ),
  ];
  final List<UserMenuItem> menus2 = [
    UserMenuItem(
      icon: 'icon_mine_invitation.png',
      label: '邀請朋友即時有禮',
    ),
  ];
  final List<UserMenuItem> menus3 = [
    UserMenuItem(
      icon: 'icon_mine_notify.png',
      label: '通知設定',
    ),
    UserMenuItem(
      icon: 'icon_mine_question.png',
      label: '常見問題',
    ),
    UserMenuItem(
      icon: 'icon_mine_contact.png',
      label: '聯絡我們',
    ),
    UserMenuItem(
      icon: 'icon_mine_terms.png',
      label: '條款及細則',
    ),
  ];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    update();
  }
}
