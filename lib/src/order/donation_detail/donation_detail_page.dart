import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'donation_detail_controller.dart';
import 'widgets/base_info.dart';
import 'widgets/delivery_info_card.dart';
import 'widgets/exchange_terms.dart';
import 'widgets/item_card.dart';

class DonationDetailPage extends StatefulWidget {
  const DonationDetailPage({Key? key}) : super(key: key);

  @override
  _DonationDetailPageState createState() => _DonationDetailPageState();
}

class _DonationDetailPageState extends State<DonationDetailPage> {
  final controller = Get.put(DonationDetailController());

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
                Padding(
                  padding: EdgeInsets.only(top: 70.w),
                ),
                const OrderItemCard(),
              ],
            ),
            const DeliveryInfoCard(),
            const OrderDetailBaseInfo(),
            SizedBox(height: 8.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
              child: const Text('捐贈說明'),
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
