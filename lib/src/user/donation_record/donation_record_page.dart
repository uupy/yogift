import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/donation_item.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'donation_record_controller.dart';
import 'widgets/item_card.dart';

class DonationRecordPage extends StatefulWidget {
  const DonationRecordPage({Key? key}) : super(key: key);

  @override
  _DonationRecordPageState createState() => _DonationRecordPageState();
}

class _DonationRecordPageState extends State<DonationRecordPage> {
  final controller = Get.put(DonationRecordController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('捐贈紀錄'),
      ),
      body: Stack(
        children: [
          HeaderBackground(
            height: 160.w,
            radius: 100.w,
          ),
          AppListView<DonationItemVo>(
            padding: EdgeInsets.only(top: 10.w),
            emptyPadding: EdgeInsets.fromLTRB(50.w, 150.w, 50.w, 0),
            waterDropColor: const Color.fromRGBO(0, 0, 0, 0.26),
            fetch: controller.queryList,
            controller: controller.listController,
            colCount: 1,
            itemBuilder: (item, index, list) {
              return OrderItemCard(item: item);
            },
          ),
        ],
      ),
    );
  }
}
