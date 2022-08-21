import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';

class GoodsDetailInfo extends StatelessWidget {
  const GoodsDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailController>(
      id: 'GoodsDetailInfo',
      builder: (c) {
        return Html(data: c.detail?.cDetail ?? '');
      },
    );
  }
}
