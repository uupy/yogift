import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/menu_row/menu_group.dart';
import 'package:yo_gift/widgets/menu_row/menu_row.dart';

import 'pay_controller.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final controller = Get.put(PayController());

  @override
  void initState() {
    if (mounted) {
      initWx();
    }
    super.initState();
  }

  Future initWx() async {
    await fluwx.registerWxApi(
      appId: Env.config.wxAppId,
      universalLink: Env.config.universalLink,
    );
    final isInstalled = await fluwx.isWeChatInstalled;
    if (isInstalled) {
      fluwx.weChatResponseEventHandler.listen((event) {
        if (event.errCode == 0) {
          controller.onPaySuccess();
        } else if (event.errCode == -2) {
          app.showToast('支付已取消');
        } else {
          app.showToast('支付失敗');
        }
      });
    }
  }

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
                  showBorder: false,
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
                loading: c.loading,
                disabled: c.loading,
                onPressed: c.onPay,
              ),
            ),
          ],
        );
      },
    );
  }
}
