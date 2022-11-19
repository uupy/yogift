import 'dart:developer';

import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';

class GiftExchangeController extends GetxController {
  final id = Get.parameters['id'];
  final title = ''.obs;

  OrderDetailItemVo? detail;

  Future fetchData() async {
    final res = await UserOrderService.getItem(id!);
    final data = res.data ?? {};

    detail = OrderDetailItemVo.fromJson(data['data'] ?? {});
    title(OrderStatus.getLabelByValue(detail?.orderStatus));

    update([
      'OrderDetailBaseInfo',
      'ExchangeInfo',
      'ExchangeCode',
      'GreetingCard',
      'ExchangeTerms',
      'OrderItemCard',
      'OrderDetailFooter'
    ]);
  }

  Future onExchange() async {
    if (detail!.writeoffCodeType != 2) {
      final res = await UserOrderService.createWriteOffCode(id!);
      final data = res.data['data'] ?? {};

      detail!.writeoffCode = data['Writeoff_Code'];
      detail!.writeoffCodeType = data['Writeoff_CodeType'];

      update(['ExchangeInfo', 'ExchangeCode']);
      fetchData();
    } else {
      detail!.writeoffCode = 'test';
      detail!.writeoffCodeType = detail!.writeoffCodeType;
      update(['ExchangeInfo', 'ExchangeCode']);
    }
  }

  Future onExchangeByCode(code) async {
    logger.i({'detail': detail!.id, 'code': code});
    final res = await UserOrderService.writeoffByCode(
        {"code": code, "id_guid": detail!.id ?? detail!.oGuid});

    if (res.data['isSuccess'] == true) {
      app.showToast('兌換成功');
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    }
  }
}
