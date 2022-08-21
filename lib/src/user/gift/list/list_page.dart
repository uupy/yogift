import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/give.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';

import 'list_controller.dart';
import 'widgets/item_card.dart';

class GiftListPage extends StatefulWidget {
  const GiftListPage({Key? key}) : super(key: key);

  @override
  _GiftListPageState createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  final controller = Get.put(GiftListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我收到的禮物'),
      ),
      body: AppListView<GiveItemVo>(
        padding: EdgeInsets.only(top: 20.w),
        emptyPadding: EdgeInsets.fromLTRB(50.w, 100.w, 50.w, 0),
        fetch: controller.queryList,
        controller: controller.listController,
        colCount: 1,
        itemBuilder: (item, index, list) {
          return OrderItemCard(item: item);
        },
      ),
    );
  }
}
