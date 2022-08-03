import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_radio.dart';

import '../goods_controller.dart';

class SearchPriceFilterBar extends StatelessWidget {
  const SearchPriceFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsController>(
      id: 'priceFilterBar',
      builder: (c) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: AppRadioGroup(
            onChanged: (value, index) {
              c.onFilterChange(value);
            },
            value: c.pricen,
            spacing: 12.w,
            runSpacing: 12.w,
            itemPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            items: [
              AppRadio(
                label: '< \$50',
                value: 1,
              ),
              AppRadio(
                label: '\$51 - \$100',
                value: 2,
              ),
              AppRadio(
                label: '\$101 - \$200',
                value: 3,
              ),
              AppRadio(
                label: '\$201 - \$500',
                value: 4,
              ),
              AppRadio(
                label: '> \$500',
                value: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}
