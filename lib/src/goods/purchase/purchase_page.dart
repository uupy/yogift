import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'widgets/detail_info.dart';
import 'widgets/footer.dart';
import 'widgets/greeting_card.dart';
import 'widgets/order_remark.dart';
import 'widgets/purchase_step_bar.dart';
import 'widgets/receiver_info.dart';
import 'widgets/sender_info.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _scrollController = ScrollController();
  final _senderWidgetKey = GlobalKey();
  final _receiverWidgetKey = GlobalKey();
  final controller = Get.put(PurchaseController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  void animateTo(BuildContext buildContext) {
    _scrollController.animateTo(
      getY(buildContext),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  double getY(BuildContext buildContext) {
    final box = buildContext.findRenderObject();
    final t = box?.getTransformTo(null);
    return t?.getTranslation().y ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isGiveToSelf ? '結賬' : '填寫心意卡'),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const HeaderBackground(),
                if (!controller.isGiveToSelf) const ProgressStepBar(),
                Padding(
                  padding: EdgeInsets.only(
                      top: controller.isGiveToSelf ? 10.w : 70.w),
                  child: const DetailInfo(),
                ),
              ],
            ),
            if (!controller.isGiveToSelf) SizedBox(height: 20.w),
            if (!controller.isGiveToSelf) const GreetingCard(),
            const OrderRemark(),
            SenderInfo(key: _senderWidgetKey),
            ReceiverInfo(key: _receiverWidgetKey),
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: PurchaseFooter(
        onTap: () {
          if (controller.senderInfoNotPerfection) {
            app.showToast('請完善送禮人資料');
            animateTo(_senderWidgetKey.currentContext!);
            return;
          }
          if (controller.receiverInfoNotPerfection) {
            app.showToast('請完善收禮人資料');
            animateTo(_receiverWidgetKey.currentContext!);
            return;
          }
          controller.onSubmit();
        },
      ),
    );
  }
}
