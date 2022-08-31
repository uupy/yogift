import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/greeting_card/greeting_card.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'give_friend_controller.dart';
import 'widgets/detail_info.dart';
import 'widgets/footer.dart';
import 'widgets/receiver_info.dart';

class OrderGiveFriendPage extends StatefulWidget {
  const OrderGiveFriendPage({Key? key}) : super(key: key);

  @override
  _OrderGiveFriendPageState createState() => _OrderGiveFriendPageState();
}

class _OrderGiveFriendPageState extends State<OrderGiveFriendPage> {
  final _scrollController = ScrollController();
  final _receiverWidgetKey = GlobalKey();
  final controller = Get.put(OrderGiveFriendController());

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
        title: const Text('贈送好友'),
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
                Padding(
                  padding: EdgeInsets.only(top: 10.w),
                  child: const DetailInfo(),
                ),
              ],
            ),
            GreetingCard(
              type: 2,
              margin: EdgeInsets.only(top: 20.w),
              onChanged: (id, msg) {
                controller.greetingCardId = id;
                controller.greetingCardMsg = msg;
              },
            ),
            ReceiverInfo(key: _receiverWidgetKey),
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: OrderGiveFriendFooter(
        onTap: () {
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
