import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class OrderExchangeTerms extends StatelessWidget {
  final String? content;
  const OrderExchangeTerms({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content ?? '',
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          lineHeight: LineHeight.number(1.3),
          fontSize: FontSize.medium,
          color: const Color.fromRGBO(0, 0, 0, 0.4),
        ),
      },
    );
  }
}
