import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/widgets/app_detail_scroll_view.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods/goods_item.dart';

import 'detail_controller.dart';
import 'widgets/app_bar_title.dart';
import 'widgets/detail_info.dart';
import 'widgets/header_backdrop.dart';
import 'widgets/sliver_background.dart';

class ShopDetailPage extends StatefulWidget {
  const ShopDetailPage({Key? key}) : super(key: key);

  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  final controller = Get.put(ShopDetailController());

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDetailScrollView(
      appBarTitle: const AppBarTitle(),
      backdrop: const HeaderBackdrop(),
      backdropBackgroundColor: Colors.white,
      backdropHeight: 185.w,
      expandedHeight: 130.w,
      sliverAppBarBackground: const SliverBackground(),
      body: Container(
        color: Colors.white,
        child: AppListView<GiftVo>(
          fetch: controller.queryList,
          controller: controller.listController,
          immediate: false,
          colCount: 2,
          prefix: const ShopDetailInfo(),
          itemsBuilder: (items, index, list) {
            return Container(
              height: 308.w,
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  ...items.map((item) {
                    return Expanded(
                      child: GoodsItem(
                        guid: item.gGuid,
                        name: item.giftName,
                        desc: item.bussinessName,
                        coverImg: item.cCoverImg,
                        buyPrice: item.buyPrice,
                        originalPrice: item.originalPrice,
                        buy1Get1Free: item.buy1Get1FREE,
                        sendingMethod: item.sendingMethod,
                        favorite: item.favorite,
                        margin: EdgeInsets.all(6.w),
                      ),
                    );
                  }).toList(),
                  if (items.length == 1) Expanded(child: Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
