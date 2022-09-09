import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/order/order_exchange_terms.dart';

import '../donation_detail_controller.dart';

class ExchangeTerms extends StatelessWidget {
  const ExchangeTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationDetailController>(
      id: 'ExchangeTerms',
      builder: (c) {
        return OrderExchangeTerms(content: c.detail?.exchangeTerms);
      },
    );
  }
}
