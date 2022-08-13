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

  /// 发送-用于更换手机号 发送验证码给新手机号码
  static Future getCodeForChangePhone(SendDataVo data) =>
      http.postJson('/VerificationCode/ChangePhone_Send', data: data);

  /// 核对-重置用户密码(未登入状态)
  static Future checkResetPwdCode(CheckCodeDataVo data) =>
      http.postJson('/VerificationCode/ResetPassword_Check', data: data);

  /// 核对-验证用户所有权(登入状态) 使用场景：更换手机号第一步
  static Future checkVerifyCode(String code) =>
      http.postJson('/VerificationCode/Verify_Check', data: {'code': code});
}
