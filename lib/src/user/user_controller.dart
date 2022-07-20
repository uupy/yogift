import 'package:get/get.dart';

class UserMenuItem {
  final String? icon;
  final String? label;
  final String? path;

  UserMenuItem(this.icon, this.label, this.path);
}

class UserController extends GetxController {
  final List<UserMenuItem> menus1 = [];
  final List<UserMenuItem> menus2 = [];
  final List<UserMenuItem> menus3 = [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    update();
  }
}
