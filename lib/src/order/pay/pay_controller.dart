import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart' hide Response;
import 'package:tobias/tobias.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/user_order/pay_type.dart';
import 'package:yo_gift/services/user_order.dart';

import 'pay_page.dart';
import 'widgets/stripe_form.dart';

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

  /// 獲取支付參數
  Future getPayParameters([Function(dynamic data)? success]) async {
    final params = {'id_guid': idGuid};
    Response? res;

    if (selectedType!.key == 'alipayHK_app') {
      res = await UserOrderService.getAliPayParameters(params);
    } else if (selectedType!.key == 'weixinpay_app') {
      res = await UserOrderService.getWxPayParameters(params);
    } else {
      res = await UserOrderService.getStripePayParameters(params);
    }

    final data = res.data ?? {};
    final message = data['message'];
    final isSuccess = data['isSuccess'] ?? false;

    if (isSuccess) {
      success?.call(data['data']);
      return data['data'];
    } else {
      app.showToast(message ?? '服務錯誤，請稍後重試');
      Get.back(result: false);
      throw Error();
    }
  }

  void onPaySuccess() {
    Navigator.pop(Get.context!);
    Get.toNamed('/pages/order/pay-result/index', parameters: {
      'orderId': idGuid,
    });
  }

  /// 支付宝支付
  Future onAliPay() async {
    final orderInfo = await getPayParameters();
    final res = await aliPay(orderInfo);
    final code = res['resultStatus'];
    final msg = res['memo'];
    if (code == '9000') {
      onPaySuccess();
    } else {
      app.showToast(msg);
    }
  }

  /// 微信支付
  Future onWxPay() async {
    final data = await getPayParameters();
    logger.i(data);
  }

  /// Stripe支付
  Future onStripePay() async {
    final data = await getPayParameters() ?? {};
    final publishableKey = data['PublishableKey'] ?? '';
    final clientSecret = data['ClientSecret'] ?? '';
    final accountId = data['Id'] ?? '';

    logger.i('PayParameters: $data');

    SmartDialog.show(
      alignment: Alignment.center,
      builder: (context) {
        return StripePayForm(
          publishableKey: publishableKey,
          clientSecret: clientSecret,
          accountId: accountId,
          onCancel: () {
            SmartDialog.dismiss();
          },
          onSuccess: () {
            SmartDialog.dismiss();
            onPaySuccess();
          },
          onFailed: (err) {},
        );
      },
    );
  }

  Future onPay() async {
    if (selectedType != null) {
      switch (selectedType!.key) {
        case 'alipayHK_app':
          onAliPay();
          break;
        case 'weixinpay_app':
          onWxPay();
          break;
        case 'stripe':
          onStripePay();
          break;
      }
    }
  }
}
