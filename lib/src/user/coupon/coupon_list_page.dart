import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/coupon_item.dart';
import 'package:yo_gift/src/user/coupon/conpon_controller.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/header_background.dart';

/// 我的優惠券

class CouponListPage extends StatefulWidget {
  const CouponListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<CouponListPage>
    with TickerProviderStateMixin {
  final controller = Get.put(CouponController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('我的優惠券'),
          bottom: TabBar(
            indicatorPadding: EdgeInsets.fromLTRB(35.w, 0, 35.w, 0),
            indicator: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 3,
              ),
            )),
            controller: _tabController,
            indicatorColor: const Color.fromRGBO(0, 0, 0, 0.9),
            labelColor: const Color.fromRGBO(0, 0, 0, 0.9),
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            tabs: const <Widget>[
              Tab(
                text: '未使用',
              ),
              Tab(
                text: '已使用',
              ),
              Tab(
                text: '已過期',
              ),
            ],
            onTap: (i) => {
              logger.i({'i': i})
            },
          )),
      body: Stack(
        children: [
          HeaderBackground(
            height: 165.w,
            radius: 100.w,
          ),
          AppListView<CouponItem>(
            fetch: controller.queryList,
            controller: controller.listController,
            colCount: 1,
            reverse: true,
            reverseData: true,
            enablePullDown: false,
            enablePullUp: false,
            emptyPadding: EdgeInsets.fromLTRB(50.w, 60.w, 50.w, 0),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
            itemBuilder: (item, index, list) {
              return Text(item.id);
            }
          ),
        ],
        
      ),
    );
  }
}
