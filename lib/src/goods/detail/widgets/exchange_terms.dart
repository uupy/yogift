import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';

class ExchangeTerms extends StatelessWidget {
  const ExchangeTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailController>(
      id: 'ExchangeTerms',
      builder: (c) {
        return Html(
          data: c.detail?.exchangeTerms ?? '',
          style: {
            'body': Style(
              margin: EdgeInsets.zero,
              lineHeight: LineHeight.number(1.3),
              fontSize: FontSize.medium,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
            'p': Style(
              margin: EdgeInsets.zero,
            ),
            'br': Style(
              height: 0,
              margin: EdgeInsets.zero,
            ),
          },
        );
      },
    );
  }
}
