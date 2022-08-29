import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/widgets/order/order_greeting_card.dart';

import '../exchange_controller.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftExchangeController>(
      id: 'GreetingCard',
      builder: (c) {
        final backgroundImage = c.detail?.greetingcardBigImg ?? '';
        final msg = c.detail?.msgGive ?? '';
        final nickName = c.detail?.nickName ?? '';

        logger.i(msg);

        return OrderGreetingCard(
          backgroundImage: backgroundImage,
          msg: msg,
          senderName: nickName,
        );
      },
    );
  }
}
