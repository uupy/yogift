import 'dart:async';

import 'package:get/get.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/user.dart';

class AccountSettingController extends GetxController {
  UserInfoVo? userInfo;
  String verifyCode = '';
  int countdown = 0;
    /// 定时器
  Timer? _timer;

    /// 轮询间隔时间
  static const _timeout = Duration(seconds: 1);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// 开启定时器
  void runTimer() {
    stopTimer();
    countdown = 60;
    update(['accountVerifyCode']);
    _timer = Timer.periodic(_timeout, (timer) {
      countdown--;
      if (countdown <= 0) {
        stopTimer();
      }
      update(['accountVerifyCode']);
    });
  }

  /// 关闭定时器
  void stopTimer() async {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  Future fetchData() async {
    final res = await UserService.getInfo();
    final data = res.data ?? {};
    userInfo = UserInfoVo.fromJson(data['data'] ?? {});
    update();
  }

  /// 刪除賬號
  Future deleteAccount(code) async {
    await UserService.removeAccount({
      "phone": userInfo?.phone,
      "phoneprefix": userInfo?.phonePrefix,
      "code": code
    });
    // update();
  }
}
