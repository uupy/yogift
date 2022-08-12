import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/goods/goods_item.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'result_controller.dart';
import 'widgets/search_bar.dart';
import 'widgets/tool_bar.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final controller = Get.put(SearchResultController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: const ToolBar(),
        ),
      ),
      body: Stack(
        children: [
          HeaderBackground(
            height: 120.w,
            radius: 100.w,
          ),
          AppListView<GiftVo>(
            emptyPadding: EdgeInsets.fromLTRB(50.w, 100.w, 50.w, 0),
            fetch: controller.queryList,
            controller: controller.listController,
            colCount: 2,
            onLoaded: (list) {
              controller.total = list.length;
              controller.update(['ToolBar']);
            },
            itemBuilder: (items, index, list) {
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
        ],
      ),
    );
  }
}
