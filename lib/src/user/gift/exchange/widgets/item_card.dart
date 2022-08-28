import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/order/order_detail_card.dart';

import '../exchange_controller.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftExchangeController>(
      id: 'OrderItemCard',
      builder: (c) {
        return OrderDetailCard(item: c.detail);
      },
    );
  }
}
