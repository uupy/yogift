import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'ask_friend_controller.dart';
import 'wisgets/detail_info.dart';
import 'wisgets/footer.dart';
import 'wisgets/greeting_card.dart';
import 'wisgets/order_remark.dart';
import 'wisgets/sender_info.dart';

class AskFriendPage extends StatefulWidget {
  const AskFriendPage({Key? key}) : super(key: key);

  @override
  _AskFriendPageState createState() => _AskFriendPageState();
}

class _AskFriendPageState extends State<AskFriendPage> {
  final _scrollController = ScrollController();
  final _senderWidgetKey = GlobalKey();
  final controller = Get.put(AskFriendController());

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
        title: const Text('拜託贈送'),
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
                  padding: EdgeInsets.only(top: 10.w),
                  child: const DetailInfo(),
                ),
              ],
            ),
            SizedBox(height: 20.w),
            const GreetingCard(),
            const OrderRemark(),
            SenderInfo(key: _senderWidgetKey),
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: AskFriendFooter(
        onTap: () {
          if (controller.senderInfoNotPerfection) {
            app.showToast('請完善送禮人資料');
            animateTo(_senderWidgetKey.currentContext!);
            return;
          }
          controller.onSubmit();
        },
      ),
    );
  }
}
