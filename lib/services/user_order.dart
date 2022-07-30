import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/user_order.dart';

class UserOrderService {
  UserOrderService._();

  /// 多步合一下单:买给自己 注册/登入->修改资料 ->购买 ->修改地址
  static Future add4Steps(UserOrderFormVo data) =>
      http.postJson('/UserOrder/Add_4Steps', data: data);
}
