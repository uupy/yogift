import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'detail_controller.dart';
import 'widgets/base_info.dart';
import 'widgets/exchange_code.dart';
import 'widgets/exchange_info.dart';
import 'widgets/exchange_terms.dart';
import 'widgets/greeting_card.dart';
import 'widgets/item_card.dart';
import 'widgets/page_footer.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final controller = Get.put(OrderDetailController());

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
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
            const ExchangeCode(),
            const GreetingCard(),
            const ExchangeInfo(),
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
      bottomNavigationBar: const OrderDetailFooter(),
    );
  }
}
