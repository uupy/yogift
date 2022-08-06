import 'package:dio/dio.dart';
import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/user.dart';

class UserService {
  UserService._();

  /// 登入:手机号码+密码
  static Future loginByPassword(LoginFormDataVo data) =>
      http.postJson('/User/GetToken', data: data);

  /// 登入:手机号码+验证码
  static Future loginByCode(LoginFormDataVo data) =>
      http.postJson('/User/GetToken_By_Code', data: data);

  /// 修改密码
  static Future modifyPassword(ModifyPwdFormVo data) =>
      http.postJson('/User/ChangePassword', data: data);

  /// 注册
  static Future register(RegisterFormVo data) =>
      http.postJson('/User/Register', data: data);

  /// 修改资料-综合
  static Future updateInfo(UpdateInfoFormVo data) =>
      http.postJson('/User/Info_set', data: data);

  /// 获取:用户信息
  static Future getInfo() =>
      http.get('/User/Info_get', options: Options(extra: {'silent': true}));
}
