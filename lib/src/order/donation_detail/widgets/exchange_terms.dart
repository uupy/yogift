import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../donation_detail_controller.dart';

class ExchangeTerms extends StatelessWidget {
  const ExchangeTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonationDetailController>(
      id: 'ExchangeTerms',
      builder: (c) {
        return Html(
          data: c.detail?.exchangeTerms ?? '',
          style: {
            'p': Style(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
          },
        );
      },
    );
  }
}
