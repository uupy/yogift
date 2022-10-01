import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/greeting_card/greeting_card.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/order/order_create_remark.dart';

import 'blessing_controller.dart';
import 'wisgets/detail_info.dart';
import 'wisgets/footer.dart';
import 'wisgets/purchase_step_bar.dart';

class CharityBlessingPage extends StatefulWidget {
  const CharityBlessingPage({Key? key}) : super(key: key);

  @override
  _CharityBlessingPageState createState() => _CharityBlessingPageState();
}

class _CharityBlessingPageState extends State<CharityBlessingPage> {
  final controller = Get.put(CharityBlessingController());

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
      extendBody: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 20.w),
            GreetingCard(
              type: 0,
              onChanged: (id, msg, imageUrl) {
                controller.addForm.bgGive = id;
                controller.addForm.msgGive = msg;
                controller.cardImageUrl = imageUrl;
              },
            ),
            OrderRemark(
              onChanged: (value) {
                controller.addForm.content2 = value;
              },
            ),
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: BlessingFooter(
        onTap: () {
          controller.onSubmit();
        },
      ),
    );
  }
}
