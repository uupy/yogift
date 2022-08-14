import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods/goods_item.dart';

import 'category_controller.dart';
import 'widgets/tabs_bar.dart';
import 'widgets/tool_bar.dart';

class SearchCategoryPage extends StatefulWidget {
  const SearchCategoryPage({Key? key}) : super(key: key);

  @override
  _SearchCategoryPageState createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  final controller = Get.put(SearchCategoryController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(96.w),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoodsCategoryTabsBar(),
                SizedBox(height: 5.w),
                const ToolBar(),
              ],
            ),
          ),
        ),
      ),
      body: AppListView<GiftVo>(
        emptyPadding: EdgeInsets.fromLTRB(50.w, 60.w, 50.w, 0),
        fetch: controller.queryList,
        immediate: false,
        controller: controller.listController,
        colCount: 2,
        onLoaded: (list) {
          controller.total = list.length;
          controller.update(['ToolBar']);
        },
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
    );
  }
}
