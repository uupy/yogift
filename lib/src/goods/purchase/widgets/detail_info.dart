import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/goods/goods_detail_card.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'DetailInfo',
      builder: (c) {
        return GoodsDetailCard(
          data: c.detail,
        );
      },
    );
  }
}
