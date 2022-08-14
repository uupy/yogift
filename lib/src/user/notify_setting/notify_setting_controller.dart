import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/user.dart';

class NotifySettingController extends GetxController {
  UserInfoVo? user;
  bool isAccept = false;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void goLogin() {
    app.showToast('請先登入');
    Get.toNamed('/login')?.then((result) {
      if (result == true) {
        fetchData();
      }
    });
  }

  Future fetchData() async {
    final _token = await accessToken.get() ?? '';
    if (_token.isNotEmpty) {
      final res = await UserService.getInfo();
      final data = res.data ?? {};
      user = UserInfoVo.fromJson(data['data'] ?? {});
      isAccept = user!.acceptNotice == 1;
      update();
    } else {
      goLogin();
    }
  }

  Future onSubmit(bool value) async {
    await UserService.updateAcceptNotice(value ? 1 : 0);
    isAccept = value;
    update();
  }
}
