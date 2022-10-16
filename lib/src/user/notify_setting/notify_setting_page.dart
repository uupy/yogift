import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'notify_setting_controller.dart';

class NotifySettingPage extends StatefulWidget {
  const NotifySettingPage({Key? key}) : super(key: key);

  @override
  _NotifySettingPageState createState() => _NotifySettingPageState();
}

class _NotifySettingPageState extends State<NotifySettingPage> {
  final controller = Get.put(NotifySettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知設定'),
      ),
      body: SingleChildScrollView(
        // physics: const ClampingScrollPhysics(),
        child: GetBuilder<NotifySettingController>(
          builder: (c) {
            return AppSimpleRow(
              margin: EdgeInsets.all(20.w),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '訂閱郵件通知',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    '開啟訂閱郵件通知後，所有消息將發至您的郵件',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                ],
              ),
              suffix: CupertinoSwitch(
                value: c.isAccept,
                onChanged: (value) {
                  logger.i(value);
                  if (c.user == null) {
                    c.goLogin();
                  } else if (c.user?.email?.isEmpty ?? true) {
                    app.confirm(
                      content: SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Text(
                              '您還沒設定郵箱',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.w),
                            Text(
                              '請前往賬戶設定設定郵箱',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        SizedBox(
                          width: 140.w,
                          child: AppButton(
                            text: '賬戶設定',
                            shadow: true,
                            onPressed: () {
                              Get.back();
                              Get.toNamed('/pages/mine/account-setting/index')
                                  ?.then((value) {
                                c.fetchData();
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    c.onSubmit(value);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
