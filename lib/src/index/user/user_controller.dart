import 'package:get/get.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/user.dart';

class UserMenuItem {
  final String? icon;
  final String? label;
  final String? path;
  final String? key;

  UserMenuItem({
    this.icon,
    this.label,
    this.path,
    this.key,
  });
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
        icon: 'icon_mine_question.png', label: '常見問題', path: './problem'),
    UserMenuItem(
      icon: 'icon_mine_contact.png',
      label: '聯絡我們',
      key: 'contact',
    ),
    UserMenuItem(icon: 'icon_mine_terms.png', label: '條款及細則', path: './clause'),
  ];

  UserInfoVo? userInfo;
  final isLogged = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    final _token = await authToken.get();
    if (_token?.isNotEmpty ?? false) {
      final res = await UserService.getInfo();
      final data = res.data ?? {};
      userInfo = UserInfoVo.fromJson(data['data'] ?? {});
      isLogged(true);
    }
    update(['UserHeaderInfo']);
  }
}
