import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'widgets/base_info.dart';
import 'widgets/deail_images.dart';
import 'widgets/detail_info.dart';
import 'widgets/exchange_terms.dart';
import 'widgets/footer.dart';
import 'widgets/tabs_bar.dart';

class GoodsDetailPage extends StatefulWidget {
  const GoodsDetailPage({Key? key}) : super(key: key);

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(GoodsDetailController());
  final _tabItems = ['商品詳情', '兌換條款'];
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    controller.init();
    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('禮物詳情'),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                HeaderBackground(height: 180.w, radius: 100.w),
                const GoodsDetailImages(),
              ],
            ),
            const GoodsDetailBaseInfo(),
            GoodsDetailTabsBar(
              items: _tabItems,
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _currentTabIndex = index;
                });
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: _currentTabIndex == 0
                  ? const GoodsDetailInfo()
                  : const ExchangeTerms(),
            ),
            SizedBox(height: 100.w),
          ],
        ),
      ),
      bottomNavigationBar: GoodsDetailFooter(
        onTap: controller.navHandling,
      ),
    );
  }
}
