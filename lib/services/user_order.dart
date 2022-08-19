import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/user_order/add.dart';
import 'package:yo_gift/models/user_order/add_4_steps.dart';
import 'package:yo_gift/models/user_order/add_for_charity_favorite.dart';
import 'package:yo_gift/models/user_order/add_for_request.dart';
import 'package:yo_gift/models/user_order/add_to_friend.dart';
import 'package:yo_gift/models/user_order/pay_type.dart';
import 'package:yo_gift/models/user_order/receiving_address.dart';

class UserOrderService {
  UserOrderService._();

  /// 多步合一下单:买给自己 注册/登入->修改资料 ->购买 ->修改地址
  static Future add4Steps(Add4StepsVo data) =>
      http.postJson('/UserOrder/Add_4Steps', data: data);

  /// 下单:买给自己
  static Future add(AddVo data) => http.postJson('/UserOrder/Add', data: data);

  /// 下单:买给别人
  static Future addToFriend(AddToFriendVo data) =>
      http.postJson('/UserOrder/Add_To_Friend', data: data);

  /// 下单:买给某个拜託
  static Future addForRequest(AddForRequestVo data) =>
      http.postJson('/UserOrder/Add_For_Request', data: data);

  /// 下单:买给某个慈善机构心願单
  static Future addForCharityFavorite(AddForCharityFavoriteVo data) =>
      http.postJson('/UserOrder/Add_For_CharityFavorite', data: data);

  /// 修改收货人资料-直接提交资料
  static Future setReceivingaddress(ReceivingAddressVo data) =>
      http.postJson('/UserOrder/Receivingaddress', data: data);

  /// 获取訂單的支付方式列表
  static Future getPayTypes(GetPayTypeDataVo data) =>
      http.postJson('/UserOrder/Get_PayType', data: data);

  /// 获取支付参数-微信 app支付
  static Future getWxPayParameters(data) =>
      http.postJson('/UserOrder/Get_Parameters_WxApp', data: data);

  /// 获取支付参数-Alipay app支付
  static Future getAliPayParameters(data) =>
      http.postJson('/UserOrder/Get_Parameters_AlipayApp', data: data);

  /// 获取stripe支付参数
  static Future getStripePayParameters(data) =>
      http.postJson('/UserOrder/Get_Parameters_Stripe', data: data);
}
