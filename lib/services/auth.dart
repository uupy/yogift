import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/auth.dart';

class AuthService {
  AuthService._();

  /// 登入:手机号码+密码
  static Future loginByPassword(PhonePasswordVo data) =>
      http.postJson('/CharityUser/GetToken', data: data);

  /// 登入:手机号码+验证码
  static Future loginByCode(PhoneCodeVo data) =>
      http.postJson('/CharityUser/GetToken_By_Code', data: data);

  /// 修改密码
  static Future modifyPassword(ModifyPwdFormVo data) =>
      http.put('/CharityUser/ChangePassword', data: data);
}
