import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/services/verification.dart';
import 'package:yo_gift/src/index/index_controller.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/menu_row/menu_group.dart';
import 'package:yo_gift/widgets/menu_row/menu_row.dart';

import 'account_setting_controller.dart';
import 'widgets/birthday_menu_row.dart';
import 'widgets/gender_menu_row.dart';
import 'widgets/menu_row.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  final controller = Get.put(AccountSettingController());

  void toEditPage(Map<String, String>? parameters) {
    Get.toNamed(
      '/pages/mine/account-setting/set-txt-val/index',
      parameters: parameters,
    )?.then((result) {
      if (result == true) {
        controller.fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('賬戶設定'),
      ),
      body: SingleChildScrollView(
        // // physics: const ClampingScrollPhysics(),
        child: GetBuilder<AccountSettingController>(
          builder: (c) {
            final data = c.userInfo;
            String address = '';
            String phone = '';

            if (data?.area0?.isNotEmpty ?? false) {
              address = '${data?.area0}${data?.area1}';
            }

            if (data?.phone?.isNotEmpty ?? false) {
              phone = '${data?.phonePrefix ?? ''} ${data?.phone ?? ''}';
            }

            return Column(
              children: [
                Stack(
                  children: [
                    const HeaderBackground(),
                    MenuGroup(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.w),
                      children: [
                        MenuRow(
                          label: '會員編號',
                          arrow: false,
                          suffix: Text(data?.id ?? ''),
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: data?.id ?? ''));
                            app.showToast('已複製');
                          },
                        ),
                        AccountSettingMenuRow(
                          label: '暱稱',
                          content: data?.nickName,
                          onTap: () {
                            toEditPage({
                              'type': 'nickname',
                              'val': data?.nickName ?? '',
                            });
                          },
                        ),
                        GenderMenuRow(
                          value: data?.gener,
                          onChanged: (value) {
                            c.fetchData();
                          },
                        ),
                        BirthdayMenuRow(
                          value: data?.birthday,
                          onChanged: (value) {
                            c.fetchData();
                          },
                        ),
                        AccountSettingMenuRow(
                          label: '居住地區',
                          content: address,
                          onTap: () {
                            const path =
                                '/pages/mine/account-setting/select-area/index';
                            Get.toNamed(path)?.then((result) {
                              if (result == true) {
                                c.fetchData();
                              }
                            });
                          },
                        ),
                        AccountSettingMenuRow(
                          label: '電郵地址',
                          content: data?.email,
                          showBottomBorder: false,
                          onTap: () {
                            toEditPage({
                              'type': 'email',
                              'val': data?.email ?? '',
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                MenuGroup(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    MenuRow(
                      label: '更新密碼',
                      onTap: () {
                        Get.toNamed('/pages/mine/user-login/set-pwd/index');
                      },
                    ),
                    AccountSettingMenuRow(
                      label: '更改電話號碼',
                      content: phone,
                      showBottomBorder: false,
                      onTap: () {
                        Get.toNamed('/pages/mine/user-login/set-mobile/index')
                            ?.then((result) {
                          if (result == true) {
                            c.fetchData();
                          }
                        });
                      },
                    ),
                  ],
                ),
                AppCard(
                  onTap: () async {
                    final result = await app.confirm(contentText: '確定要退出登錄嗎？');
                    if (result == true) {
                      app.logout(success: () {
                        final indexController = Get.find<IndexController>();
                        Get.offAllNamed('/index');
                        indexController.switchTabBar(0);
                      });
                    }
                  },
                  margin: EdgeInsets.all(20.w),
                  blurRadius: 2.r,
                  child: Center(
                    child: Text(
                      '登出',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xffff3b30),
                      ),
                    ),
                  ),
                ),
                AppCard(
                  onTap: () async {
                    c.verifyCode = '';

                    final result = await app.confirm(
                      height: 240.w,
                      title: '刪除賬號',
                      content: Container(
                          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                          margin: EdgeInsets.only(bottom: 30.w),
                          child: GetBuilder<AccountSettingController>(
                            id: 'accountVerifyCode',
                            builder: (c2) {
                              return FormItem(
                                label: '驗證碼',
                                hintText: '請輸入驗證碼',
                                padding: EdgeInsets.only(left: 10.w),
                                keyboardType: TextInputType.number,
                                actions: [
                                  Container(
                                    margin: EdgeInsets.all(6.w),
                                    child: AppButton(
                                      round: false,
                                      fixedSize: Size(84.w, 32.w),
                                      fontSize: 12.sp,
                                      text: c2.countdown > 0
                                          ? '${c2.countdown}s'
                                          : '獲取驗證碼',
                                      onPressed: () async {
                                        await VerificationService.verifySend();
                                        c2.runTimer();
                                      },
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  c2.verifyCode = value!;
                                  c2.update(['accountVerifyCode']);
                                },
                              );
                            },
                          )),
                    );

                    if (result == true) {
                      if (c.verifyCode == '') {
                        app.showToast('請輸入驗證碼！');
                        return;
                      }
                      await controller.deleteAccount('code');

                      app.removeAccount(success: () {
                        Get.offAllNamed('/login');
                      });
                    }
                  },
                  margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  blurRadius: 2.r,
                  child: Center(
                    child: Text(
                      '刪除賬號',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xffff3b30),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
