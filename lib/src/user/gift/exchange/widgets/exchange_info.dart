import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

import '../exchange_controller.dart';
import 'exchange_code.dart';

class ExchangeInfo extends StatelessWidget {
  const ExchangeInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftExchangeController>(
      id: 'ExchangeInfo',
      builder: (c) {
        if ( c.detail?.writeoffCode?.isNotEmpty ?? false) {
          return const ExchangeCode();
        }
        return Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppAssetImage(
                    width: 16.w,
                    margin: EdgeInsets.only(right: 8.w),
                    img: 'icon_warning.png',
                  ),
                  Text(
                    '請確保到達店鋪時，才按下「現在兌換」',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.w),
              AppButton(
                text: '現在兌換',
                shadow: true,
                onPressed: () async {
                  final res = await app.confirm(
                    title: '確認現在兌換？',
                    contentText: '請確保到達店鋪準備好領取禮物時才按「現在兌換」',
                    content: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Center(
                        child: Text(
                          '請確保到達店鋪準備好領取禮物時才按「現在兌換」',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                      ),
                    ),
                    cancelText: '下次再兌換',
                    confirmText: '現在兌換',
                  );
                  if (res == true) {
                    c.onExchange();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
