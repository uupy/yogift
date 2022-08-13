import 'package:get/get.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/user.dart';

class AccountSettingController extends GetxController {
  UserInfoVo? userInfo;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future fetchData() async {
    final res = await UserService.getInfo();
    final data = res.data ?? {};
    userInfo = UserInfoVo.fromJson(data['data'] ?? {});
    update();
  }
}
