import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import '../pay_result_controller.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CharityPayResultController>(
      id: 'ResultCard',
      init: CharityPayResultController(),
      builder: (c) {
        return Container(
          width: double.maxFinite,
          height: 114.w,
          margin: EdgeInsets.only(bottom: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        );
      },
    );
  }
}
