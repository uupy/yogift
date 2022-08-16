import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_radio.dart';

import '../detail_controller.dart';
import 'sku_select_footer.dart';
import 'sku_select_header.dart';

class SkuSelectView extends StatelessWidget {
  final Function()? onConfirm;

  const SkuSelectView({Key? key, this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailController>(
      id: 'SkuSelectView',
      builder: (c) {
        final buyType = c.buyType;
        final sku = c.selectSku;
        final specs = c.detail?.specs ?? [];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkuSelectHeader(
              sku: sku,
              selectName: c.selectSkuItemNames,
              defaultCoverImg: c.detail?.cCoverImg,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height / 2 - 40.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: specs.asMap().keys.map((index) {
                    final e = specs[index];
                    final items = e.specValues ?? [];
                    final selectItemKey = c.selectSkuKeys.isNotEmpty
                        ? c.selectSkuKeys[index]
                        : null;

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
                            itemPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.w,
                            ),
                            color: const Color(0xfff7f7f7),
                            borderColor: const Color(0xfff7f7f7),
                            selectedColor:
                                const Color.fromRGBO(255, 225, 0, .1),
                            selectedBorderColor: const Color(0xffffe100),
                            value: selectItemKey,
                            items: items.map((item) {
                              return AppRadio(
                                label: item.value,
                                value: '${item.id}',
                              );
                            }).toList(),
                            onChanged: (value, idx) {
                              if (c.selectSkuKeys.isNotEmpty) {
                                c.selectSkuKeys[index] = value;
                                c.update(['SkuSelectView']);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SkuSelectFooter(
              sku: sku,
              buyType: buyType,
              onTap: onConfirm,
            ),
          ],
        );
      },
    );
  }
}
