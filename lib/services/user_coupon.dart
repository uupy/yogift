import 'package:dio/dio.dart';
import 'package:yo_gift/common/http.dart';

class UserCoupon {
  UserCoupon._();
  
  /// 我的优惠券
  static Future<Response<dynamic>> queryUserCouponList(data) =>
      http.postJson('/Ygcoupon/UserYgcouponList', data: data);
}
