import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_input.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods_item.dart';
import 'package:yo_gift/widgets/module_title.dart';

import 'search_controller.dart';
import 'widgets/category_list.dart';
import 'widgets/price_filter_bar.dart';
import 'widgets/recommend_titles.dart';
import 'widgets/scene_list.dart';
import 'widgets/sort_bar.dart';

class SearchPage extends StatelessWidget implements TabBarPage {
  SearchPage({Key? key}) : super(key: key);

  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return AppListView<GiftVo>(
      fetch: controller.queryList,
      controller: controller.listController,
      colCount: 2,
      prefix: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SearchRecommendTitles(),
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
      itemBuilder: (items, index, list) {
        return Container(
          height: 308.w,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              ...items.map((item) {
                return Expanded(
                  child: GoodsItem(
                    name: item.giftName,
                    desc: item.bussinessName,
                    coverImg: item.cCoverImg,
                    buyPrice: item.buyPrice,
                    originalPrice: item.originalPrice,
                    buy1Get1Free: item.buy1Get1FREE,
                    sendingMethod: item.sendingMethod,
                    margin: EdgeInsets.all(6.w),
                  ),
                );
              }).toList(),
              if (items.length < 2) Expanded(child: Container()),
            ],
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: SizedBox(
        height: 36.w,
        child: AppInput(
          padding: EdgeInsets.only(left: 10.w),
          hintText: '搜尋禮品、商戶名',
          radius: Radius.circular(36.w),
          backgroundColor: Colors.white,
          textInputAction: TextInputAction.search,
          prefix: [
            AppAssetImage(
              width: 16.w,
              margin: EdgeInsets.only(left: 6.w, right: 6.w),
              img: 'icon_search.png',
            ),
          ],
          actions: [
            Padding(
              padding: EdgeInsets.all(2.w),
              child: AppButton(
                fixedSize: Size(60.w, 32.w),
                text: '搜尋',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
