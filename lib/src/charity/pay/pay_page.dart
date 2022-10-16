import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'pay_controller.dart';
import 'widgets/delivery_info_card.dart';
import 'widgets/footer.dart';
import 'widgets/item_card.dart';

class CharityPayPage extends StatefulWidget {
  const CharityPayPage({Key? key}) : super(key: key);

  @override
  _CharityPayPageState createState() => _CharityPayPageState();
}

class _CharityPayPageState extends State<CharityPayPage> {
  final controller = Get.put(CharityPayController());

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('確認捐贈'),
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
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: CharityPayFooter(
        onTap: () {
          controller.onPay();
        },
      ),
    );
  }
}
