import 'package:get/get.dart';
import 'package:tobias/tobias.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/user_order/pay_type.dart';
import 'package:yo_gift/services/user_order.dart';

import 'pay_page.dart';

class PayController extends GetxController {
  List<PayTypeVo> payTypes = [];
  PayTypeVo? selectedType;
  String idGuid = '';

  /// 获取支付方式列表
  Future fetchData(String idGuid) async {
    final params = GetPayTypeDataVo(
      idGuid: idGuid,
      scene: 4,
      paycallbackurl: '',
    );
    final res = await UserOrderService.getPayTypes(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    payTypes = items.map((e) => PayTypeVo.fromJson(e)).toList();
    if (payTypes.isNotEmpty) {
      selectedType = payTypes.first;
    }
    update();
  }

  /// 显示支付弹窗
  Future showModal(String orderId) async {
    idGuid = orderId;
    fetchData(orderId);
    return await app.showBottomModal(
      context: Get.context!,
      builder: (context) {
        return const PayPage();
      },
    );
  }

  /// 支付宝支付
  Future onAliPay() async {
    try {
      final res = await UserOrderService.getAliPayParameters({
        'id_guid': idGuid,
      });
      final data = res.data ?? {};
      final orderInfo = data['data'] ?? '';
      final result = await aliPay(orderInfo);
      logger.i(result);
    } catch (err) {
      String msg = '';
      if (err is Exception) {
        msg = err.toString();
      } else {
        msg = '$err';
      }
      logger.e(msg);
      app.showToast(msg);
    }
  }

  /// 微信支付
  Future onWxPay() async {}

  /// Stripe支付
  Future onStripePay() async {}

  Future onPay() async {
    if (selectedType != null) {
      switch (selectedType!.key) {
        case 'alipayHK_app':
          onAliPay();
          break;
        case 'weixinpay_app':
          onWxPay();
          break;
        case 'stripepay_app':
          onStripePay();
          break;
      }
    }
  }
}
