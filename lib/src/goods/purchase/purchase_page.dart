import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/focus_monitoring.dart';
import 'package:yo_gift/widgets/greeting_card/greeting_card.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/order/order_create_remark.dart';

import 'purchase_controller.dart';
import 'widgets/app_bar_title.dart';
import 'widgets/detail_info.dart';
import 'widgets/donation_charity_info.dart';
import 'widgets/footer.dart';
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
    return FocusMonitoring(
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(),
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
              if (!controller.isGiveToSelf)
                GreetingCard(
                  type: 2,
                  margin: EdgeInsets.only(top: 20.w),
                  onChanged: (id, msg, image) {
                    controller.greetingCardId = id;
                    controller.greetingCardMsg = msg;
                    controller.greetingCardImage = image;
                  },
                ),
              if (controller.orderId.isEmpty)
                OrderRemark(
                  onChanged: (value) {
                    controller.remark = value ?? '';
                  },
                ),
              const DonationCharityInfo(),
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
      ),
    );
  }
}
