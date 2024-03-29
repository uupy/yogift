import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'deliver_controller.dart';
import 'widgets/base_info.dart';
import 'widgets/content_button.dart';
import 'widgets/exchange_terms.dart';
import 'widgets/item_card.dart';
import 'widgets/page_footer.dart';
import 'widgets/progress_step_bar.dart';
import 'widgets/receiving_info.dart';

class GiftDeliverPage extends StatefulWidget {
  const GiftDeliverPage({Key? key}) : super(key: key);

  @override
  _GiftDeliverPageState createState() => _GiftDeliverPageState();
}

class _GiftDeliverPageState extends State<GiftDeliverPage> {
  final controller = Get.put(GiftDeliverController());

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
        // physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const HeaderBackground(),
                const DeliverProgressStepBar(),
                Padding(
                  padding: EdgeInsets.only(top: 52.w),
                  child: const OrderItemCard(),
                ),
              ],
            ),
            const ReceivingInfo(),
            const ContentButton(),
            const GiftDeliverBaseInfo(),
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
      bottomNavigationBar: const GiftDeliverFooter(),
    );
  }
}
