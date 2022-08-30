import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';

import 'list_controller.dart';
import 'widgets/item_card.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  final controller = Get.put(AddressListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收貨地址'),
        actions: [
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Text(
                  '完成',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.9),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AppListView<ReceivingAddressVo>(
        padding: EdgeInsets.only(top: 12.w),
        fetch: controller.queryList,
        controller: controller.listController,
        hasPage: false,
        colCount: 1,
        itemBuilder: (item, index, list) {
          return AddressItemCard(item: item);
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20.w),
        child: AppButton(
          text: '添加收貨地址',
          onPressed: () {
            Get.toNamed('/pages/mine/addr-edit/index');
          },
        ),
      ),
    );
  }
}
