import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'widgets/detail_info.dart';
import 'widgets/purchase_step_bar.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final controller = Get.put(PurchaseController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('填寫心意卡'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const HeaderBackground(),
                const ProgressStepBar(),
                Padding(
                  padding: EdgeInsets.only(top: 70.w),
                  child: const DetailInfo(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
