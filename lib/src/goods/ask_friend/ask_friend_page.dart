import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/focus_monitoring.dart';
import 'package:yo_gift/widgets/greeting_card/greeting_card.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/order/order_create_remark.dart';

import 'ask_friend_controller.dart';
import 'wisgets/detail_info.dart';
import 'wisgets/footer.dart';

class AskFriendPage extends StatefulWidget {
  const AskFriendPage({Key? key}) : super(key: key);

  @override
  _AskFriendPageState createState() => _AskFriendPageState();
}

class _AskFriendPageState extends State<AskFriendPage> {
  final controller = Get.put(AskFriendController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusMonitoring(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('拜託贈送'),
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
                    padding: EdgeInsets.only(top: 10.w),
                    child: const DetailInfo(),
                  ),
                ],
              ),
              GreetingCard(
                type: 1,
                margin: EdgeInsets.only(top: 20.w),
                onChanged: (id, msg, image) {
                  controller.baseForm.gCGuid = id;
                  controller.baseForm.msgRequest = msg;
                  controller.cardImageUrl = image;
                },
              ),
              OrderRemark(
                onChanged: (value) {
                  controller.baseForm.content2 = value ?? '';
                },
              ),
              SizedBox(height: 100.w),
            ],
          ),
        ),
        bottomNavigationBar: AskFriendFooter(
          onTap: () {
            controller.onSubmit();
          },
        ),
      ),
    );
  }
}
