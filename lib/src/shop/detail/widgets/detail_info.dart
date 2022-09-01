import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_radio.dart';
import 'package:yo_gift/widgets/app_tag.dart';

import '../detail_controller.dart';

class ShopDetailInfo extends StatelessWidget {
  const ShopDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailController>(
      id: 'ShopDetailInfo',
      builder: (c) {
        final keywords = c.detail?.keywords ?? [];

        return Container(
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
        );
      },
    );
  }
}
