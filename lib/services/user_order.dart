import 'package:dio/dio.dart';
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

  /// 用于訂單筛选
  static Future<Response<dynamic>> queryPage(data) =>
      http.postJson('/UserOrder/List_By_OrderStatus', data: data);

  /// 我的捐贈单
  static Future<Response<dynamic>> queryPageForCharity(data) =>
      http.postJson('/UserOrder/List_For_Charity', data: data);

  /// 单个
  static Future<Response<dynamic>> getItem(String id) =>
      http.postJson('/UserOrder/Item', data: {
        'id_guid': id,
      });

  /// 关闭订单
  static Future<Response<dynamic>> closeItem(String id) =>
      http.postJson('/UserOrder/CloseOrder', data: {
        'Id_Guid': id,
      });

  /// 確認收貨
  static Future<Response<dynamic>> receivingConfirm(String id) =>
      http.postJson('/UserOrder/Receiving_Confirm', data: {
        'Id_Guid': id,
      });

  /// 修改訂單收貨地址
  static Future<Response<dynamic>> updateReceivingAddressById(
          String orderId, int addressId) =>
      http.postJson('/UserOrder/Receivingaddress_By_Id', data: {
        'id_guid': orderId,
        'receivingaddress_id': addressId,
      });

  /// 確認訂單收貨地址
  static Future<Response<dynamic>> confirmReceivingAddress(String orderId) =>
      http.postJson('/UserOrder/Receivingaddress_Confirm', data: {
        'id_guid': orderId,
      });

  ///
  static Future<Response<dynamic>> createWriteOffCode(String id) =>
      http.postJson('/UserOrder/Create_WriteOffCode', data: {
        'Id_Guid': id,
      });

  /// 多步合一下单:买给自己 注册/登入->修改资料 ->购买 ->修改地址
  static Future<Response<dynamic>> add4Steps(Add4StepsVo data) => http.postJson(
        '/UserOrder/Add_4Steps',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 下单:买给自己
  static Future<Response<dynamic>> add(AddVo data) => http.postJson(
        '/UserOrder/Add',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 下单:买给别人
  static Future<Response<dynamic>> addToFriend(AddToFriendVo data) =>
      http.postJson(
        '/UserOrder/Add_To_Friend',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 下单:买给某个拜託
  static Future<Response<dynamic>> addForRequest(AddForRequestVo data) =>
      http.postJson(
        '/UserOrder/Add_For_Request',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 下单:买给某个慈善机构心願单
  static Future<Response<dynamic>> addForCharityFavorite(
          AddForCharityFavoriteVo data) =>
      http.postJson(
        '/UserOrder/Add_For_CharityFavorite',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 修改收货人资料-直接提交资料
  static Future<Response<dynamic>> setReceivingaddress(
          ReceivingAddressVo data) =>
      http.postJson('/UserOrder/Receivingaddress', data: data);

  /// 查询訂單支付状态
  static Future<Response<dynamic>> getPayResult(String orderId) =>
      http.postJson(
        '/UserOrder/GetQueryOrderResult',
        data: {'O_Guid': orderId},
      );

  /// 获取訂單的支付方式列表
  static Future<Response<dynamic>> getPayTypes(GetPayTypeDataVo data) =>
      http.postJson(
        '/UserOrder/Get_PayType',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 获取支付参数-微信 app支付
  static Future<Response<dynamic>> getWxPayParameters(data) => http.postJson(
        '/UserOrder/Get_Parameters_WxApp',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 获取支付参数-Alipay app支付
  static Future<Response<dynamic>> getAliPayParameters(data) => http.postJson(
        '/UserOrder/Get_Parameters_AlipayApp',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );

  /// 获取stripe支付参数
  static Future<Response<dynamic>> getStripePayParameters(data) =>
      http.postJson(
        '/UserOrder/Get_Parameters_Stripe',
        data: data,
        options: Options(extra: {'ignoreErrors': true}),
      );
}
