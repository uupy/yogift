import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_radio.dart';

import '../detail_controller.dart';
import 'sku_select_footer.dart';
import 'sku_select_header.dart';

class SkuSelectView extends StatelessWidget {
  const SkuSelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailController>(
      id: 'SkuSelectView',
      builder: (c) {
        final sku = c.selectSku;
        final specs = c.detail?.specs ?? [];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkuSelectHeader(sku: sku),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height / 2 - 40.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: specs.map((e) {
                    final items = e.specValues ?? [];

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12.w, bottom: 8.w),
                            child: Text(
                              e.name ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AppRadioGroup(
                            items: items.map((item) {
                              return AppRadio(
                                label: item.value,
                                value: item.id,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SkuSelectFooter(total: sku.buyPrice),
          ],
        );
      },
    );
  }
}
