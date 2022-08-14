import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods/goods_item.dart';
import 'package:yo_gift/widgets/module_title.dart';

import 'goods_controller.dart';
import 'widgets/category_list.dart';
import 'widgets/price_filter_bar.dart';
import 'widgets/recommend_titles.dart';
import 'widgets/scene_list.dart';
import 'widgets/search_bar.dart';
import 'widgets/search_history_bar.dart';
import 'widgets/sort_bar.dart';

class GoodsPage extends StatelessWidget implements TabBarPage {
  GoodsPage({Key? key}) : super(key: key);

  final controller = Get.put(GoodsController());

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: SearchBar(
        onSearch: controller.onSearch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppListView<GiftVo>(
      fetch: controller.queryList,
      controller: controller.listController,
      colCount: 2,
      footerHeight: 120,
      footerPadding: EdgeInsets.only(top: 10.w),
      prefix: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SearchRecommendTitles(),
          SearchHistoryBar(),
          ModuleTitle(
            textCn: '送禮場景',
            textEn: 'SCENARIO',
          ),
          SearchSceneList(),
          ModuleTitle(
            textCn: '禮物類型',
            textEn: 'CATEGORY',
          ),
          SearchCategoryList(),
          ModuleTitle(
            textCn: '全部禮物',
            textEn: 'ALL GIFTS',
            suffix: SearchSortBar(),
          ),
          SearchPriceFilterBar(),
          SizedBox(height: 20),
        ],
      ),
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
    );
  }
}
