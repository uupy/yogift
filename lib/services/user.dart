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

  /// 修改资料-昵称
  static Future updateNickName(String value) =>
      http.postJson('/User/NickName_set', data: {'nickname': value});

  /// 修改资料-性别
  static Future updateGender(int value) =>
      http.postJson('/User/Gener_set', data: {'gener': value});

  /// 修改资料-生日
  static Future updateBirthday(String value) =>
      http.postJson('/User/Birthday_set', data: {'birthday': value});

  /// 修改资料-邮箱
  static Future updateEmail(String value) =>
      http.postJson('/User/Email_set', data: {'email': value});

  /// 修改资料-二级区域
  static Future updateArea(data) => http.postJson('/User/Area_set', data: data);

  /// 修改资料-手机号码 上一步：旧手机短信获取操作码
  static Future updatePhone(SetPhoneFormVo data) =>
      http.postJson('/User/Phone_set', data: data);

  /// 修改资料-同意接收推广告电邮以及好友生日提醒
  static Future updateAcceptNotice(int value) =>
      http.postJson('/User/AcceptNotice_set', data: {'acceptnotice': value});

  /// 修改资料-公开心願单(默认公开)
  static Future updateFavoriteOpen(int value) =>
      http.postJson('/User/Favoriteopen_set', data: {'favorite_open': value});

  /// 修改密码:通过旧密码
  static Future updatePassword(data) =>
      http.postJson('/User/ChangePassword', data: data);

  /// 修改密码:账号未设置密码前才能使用这一步
  static Future bindPassword(String value) =>
      http.postJson('/User/BindPassword', data: {'password': value});

  /// 重置密码:通过短信验证码进行操作
  static Future resetPassword(ResetPwdFormVo data) =>
      http.postJson('/User/ResetPassword', data: data);

  /// 获取:用户信息
  static Future getInfo() =>
      http.get('/User/Info_get', options: Options(extra: {'silent': true}));

  /// 刷新token
  static Future refreshToken(String refreshToken) => http.postJson(
        '/User/RefreshToken',
        data: {'refreshtoken': refreshToken},
        options: Options(
          extra: {'silent': true},
        ),
      );
}
