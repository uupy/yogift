import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../pay_result_controller.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayResultController>(
      id: 'ResultCard',
      init: PayResultController(),
      builder: (c) {
        return AppCard(
          margin: EdgeInsets.only(bottom: 30.w),
          child: Column(
            children: [
              if (c.payStatus == 2)
                AppAssetImage(
                  width: 52.w,
                  height: 52.w,
                  margin: EdgeInsets.only(bottom: 8.w),
                  img: 'icon_success.png',
                ),
              Text(
                c.statusName,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/pages/mine/order/detail/index', parameters: {
                    'id': c.orderId!,
                  });
                },
                child: Text(
                  '查看訂單',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff007aff),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              AppSimpleRow(
                margin: EdgeInsets.only(top: 32.w, bottom: 24.w),
                children: [
                  Expanded(
                    child: AppButton(
                      text: '送給好友',
                      backgroundColor: const Color(0xfffffdeb),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: AppButton(
                      text: '返回主頁',
                      onPressed: () {
                        Get.offAllNamed('/index');
                      },
                    ),
                  ),
                ],
              ),
              Text(
                '發送給好友，好友即可領取或輸入配送地址收貨。若對方超過24小時未領取，禮物將自動退回',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xffff3b30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
