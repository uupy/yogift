import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/user.dart';

class UserService {
  UserService._();

  /// 登入:手机号码+密码
  static Future loginByPassword(PhonePasswordVo data) =>
      http.postJson('/User/GetToken', data: data);

  /// 登入:手机号码+验证码
  static Future loginByCode(PhoneCodeVo data) =>
      http.postJson('/User/GetToken_By_Code', data: data);

  /// 修改密码
  static Future modifyPassword(ModifyPwdFormVo data) =>
      http.postJson('/User/ChangePassword', data: data);

  /// 修改密码
  static Future register(RegisterFormVo data) =>
      http.postJson('/User/Register', data: data);
}
