import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_list_item.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'list_controller.dart';
import 'widgets/filter_button.dart';
import 'widgets/item_card.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final controller = Get.put(OrderListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('查看訂單'),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: const OrderListFilterButton(),
          ),
        ],
      ),
      body: Stack(
        children: [
          HeaderBackground(
            height: 160.w,
            radius: 100.w,
          ),
          AppListView<OrderListItemVo>(
            padding: EdgeInsets.only(top: 10.w),
            emptyPadding: EdgeInsets.fromLTRB(50.w, 100.w, 50.w, 0),
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
