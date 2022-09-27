import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/order/order_exchange_code.dart';

import '../exchange_controller.dart';

class ExchangeCode extends StatelessWidget {
  const ExchangeCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftExchangeController>(
      id: 'ExchangeCode',
      builder: (c) {
        final giftName = c.detail?.giftName ?? '';
        final nums = c.detail?.nums ?? 1;
        final code = c.detail?.writeoffCode ?? '';
        final codeType = c.detail?.writeoffCodeType ?? 0;
        final expirationTime = c.detail?.expirationTime ?? '';
        final time = c.detail?.writeoffTimeN ?? 0;

        return OrderExchangeCode(
          expirationTime: expirationTime,
          giftName: giftName,
          nums: nums,
          code: code,
          codeType: codeType,
          time: time,
          onTimeout: () {
            Get.back();
          },
        );
      },
    );
  }
}
