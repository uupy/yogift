import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'exchange_controller.dart';
import 'widgets/base_info.dart';
import 'widgets/exchange_info.dart';
import 'widgets/exchange_terms.dart';
import 'widgets/greeting_card.dart';
import 'widgets/item_card.dart';

class GiftExchangePage extends StatefulWidget {
  const GiftExchangePage({Key? key}) : super(key: key);

  @override
  _GiftExchangePageState createState() => _GiftExchangePageState();
}

class _GiftExchangePageState extends State<GiftExchangePage> {
  final controller = Get.put(GiftExchangeController());

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('兌換禮物'),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const HeaderBackground(),
                Padding(
                  padding: EdgeInsets.only(top: 70.w),
                ),
                const OrderItemCard(),
              ],
            ),
            const ExchangeInfo(),
            const GreetingCard(),
            const OrderDetailBaseInfo(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
              child: const Text('兌換條款及細則'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: const ExchangeTerms(),
            ),
            SizedBox(height: 100.w),
          ],
        ),
      ),
    );
  }
}
