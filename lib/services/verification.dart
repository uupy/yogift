import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/verification.dart';

class VerificationService {
  VerificationService._();

  /// 发送-用于登入
  static Future getCodeForLogin(SendDataVo data) =>
      http.postJson('/VerificationCode/Login_Send', data: data);

  /// 发送-用于注册
  static Future getCodeForRegister(SendDataVo data) =>
      http.postJson('/VerificationCode/Register_Send', data: data);

  /// 发送-用于重置密码
  static Future getCodeForResetPwd(SendDataVo data) =>
      http.postJson('/VerificationCode/ResetPassword_Send', data: data);
}
