import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/menu_row/menu_group.dart';
import 'package:yo_gift/widgets/menu_row/menu_row.dart';

import 'pay_controller.dart';

class PayPage extends StatelessWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayController>(
      init: PayController(),
      builder: (c) {
        final selected = c.selectedType;
        final list = c.payTypes;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 54.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.w),
                  topLeft: Radius.circular(20.w),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 40.w),
                  Expanded(
                    child: Center(
                      child: Text(
                        '選擇支付方式',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  AppAssetImage(
                    width: 20.w,
                    margin: EdgeInsets.only(right: 20.w),
                    img: 'icon_close.png',
                    onTap: () {
                      Get.back(result: false);
                    },
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height / 2 - 40.w),
              child: SingleChildScrollView(
                child: MenuGroup(
                  padding: EdgeInsets.zero,
                  blurRadius: 0,
                  children: list.map((item) {
                    final active = selected?.id == item.id;

                    return MenuRow(
                      label: item.title,
                      arrow: false,
                      prefix: AppImage(
                        url: item.icon,
                        width: 24.w,
                        height: 24.w,
                        crop: false,
                        margin: EdgeInsets.only(right: 8.w),
                      ),
                      suffix: AppAssetImage(
                        width: 16.w,
                        img: 'icon_cb_${active ? 1 : 0}.png',
                      ),
                      onTap: () {
                        c.selectedType = item;
                        c.update();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: AppButton(
                text: '立即支付',
                onPressed: c.onPay,
              ),
            ),
          ],
        );
      },
    );
  }
}
