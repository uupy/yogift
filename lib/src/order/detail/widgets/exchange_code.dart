import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/order/order_exchange_code.dart';

import '../detail_controller.dart';

class ExchangeCode extends StatelessWidget {
  const ExchangeCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      id: 'ExchangeCode',
      builder: (c) {
        final orderStatus = c.detail?.orderStatus;
        final giftName = c.detail?.giftName ?? '';
        final nums = c.detail?.nums ?? 1;
        final code = c.detail?.writeoffCode ?? '';
        final codeType = c.detail?.writeoffCodeType ?? 0;
        final expirationTime = c.detail?.expirationTime ?? '';

        if (!c.isThirdParty || ![2, 3].contains(orderStatus)) {
          return Container();
        }

        return OrderExchangeCode(
          expirationTime: expirationTime,
          giftName: giftName,
          nums: nums,
          code: code,
          codeType: codeType,
          time: c.detail?.writeoffTimeN ?? 0,
        );
      },
    );
  }
}
