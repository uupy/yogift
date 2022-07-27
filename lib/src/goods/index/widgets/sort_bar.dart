import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/index/index_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class SearchSortBar extends StatelessWidget {
  const SearchSortBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsIndexController>(
      id: 'sortBar',
      builder: (c) {
        String img = 'icon_order_none.png';

        if (c.orderby == 4) {
          img = 'icon_order_ascend.png';
        } else if (c.orderby == 5) {
          img = 'icon_order_descend.png';
        }

        return GestureDetector(
          onTap: () {
            int? value = c.orderby;
            if (c.orderby == null) {
              value = 4;
            } else if (c.orderby == 4) {
              value = 5;
            } else if (c.orderby == 5) {
              value = null;
            }
            c.onSortChange(value);
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                '價格',
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
              AppAssetImage(
                width: 14.w,
                img: img,
              ),
            ],
          ),
        );
      },
    );
  }
}
