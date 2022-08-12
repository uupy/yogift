import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/widgets/app_detail_scroll_view.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/app_radio.dart';
import 'package:yo_gift/widgets/app_tag.dart';
import 'package:yo_gift/widgets/goods/goods_item.dart';
import 'package:yo_gift/widgets/header_background.dart';

import 'detail_controller.dart';

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
    return GetBuilder<ShopDetailController>(
      builder: (c) {
        final keywords = c.detail?.keywords ?? [];

        return AppDetailScrollView(
          appBarTitle: Text(c.detail?.bussinessName ?? ''),
          backdrop: HeaderBackground(
            color: Colors.white,
            child: AppImage(
              url: c.detail?.bussinessImgBg,
            ),
          ),
          backdropBackgroundColor: Colors.white,
          backdropHeight: 185.w,
          expandedHeight: 130.w,
          sliverAppBarBackground: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppImage(
                width: 100.w,
                height: 100.w,
                radius: 100.w,
                border: Border.all(
                  color: const Color(0xfff5f5f5),
                ),
                alignment: Alignment.bottomCenter,
                url: c.detail?.bussinessImg,
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            child: AppListView<GiftVo>(
              fetch: c.queryList,
              immediate: false,
              controller: c.listController,
              colCount: 2,
              prefix: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.detail?.bussinessName ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.w),
                      child: Text(c.detail?.cDetail ?? ''),
                    ),
                    AppRadioGroup(
                      onChanged: (value, index) {
                        c.onFilterChange(value);
                      },
                      cancelAble: true,
                      value: c.giftName,
                      items: keywords.map((e) {
                        return AppRadio(
                          value: e,
                          label: '#$e',
                          builder: (selected) {
                            return AppTag(
                              text: '#$e',
                              showShape: selected,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
      },
    );
  }
}
