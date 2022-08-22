import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/app_button.dart';

import '../detail_controller.dart';

class ExchangeInfo extends StatelessWidget {
  const ExchangeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      id: 'ExchangeInfo',
      builder: (c) {
        final code = c.detail?.writeoffCode ?? '';

        if (!c.isExchanged || !c.isThirdParty) {
          return Container();
        }

        return Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: Column(
            children: [
              Text(
                '該商品在第三方平台兌換，請複製券碼到第三方平台兌換',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
              SizedBox(height: 32.w),
              Text(
                '券碼',
                style: TextStyle(fontSize: 14.sp),
              ),
              Container(
                width: 280.w,
                height: 46.w,
                margin: EdgeInsets.only(top: 8.w, bottom: 32.w),
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa),
                  borderRadius: BorderRadius.all(Radius.circular(8.w)),
                ),
                child: Center(
                  child: Text(
                    code,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              AppButton(
                text: '複製兌換碼',
                shadow: true,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: code));
                  app.showToast('已複製');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
