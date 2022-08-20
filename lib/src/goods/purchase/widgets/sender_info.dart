import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/purchase_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_row.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/phone_prefix_select.dart';

import 'sender_info_tab_bar.dart';

class SenderInfo extends StatefulWidget {
  const SenderInfo({Key? key}) : super(key: key);

  @override
  _SenderInfoState createState() => _SenderInfoState();
}

class _SenderInfoState extends State<SenderInfo> {
  final List<String> _tabItems = ['我是新用戶', '我是舊用戶'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'SenderInfo',
      builder: (c) {
        if (!c.isLogged) {
          return Container();
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '送禮人資料',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DefaultTabController(
                length: _tabItems.length,
                child: SenderInfoTabBar(
                  items: _tabItems,
                  onTap: (index) {
                    c.isNewUser = index == 0;
                    c.update(['SenderInfo']);
                  },
                ),
              ),
              SizedBox(height: 12.w),
              Row(
                children: [
                  FormItem(
                    width: 96.w,
                    margin: EdgeInsets.only(right: 8.w),
                    label: '區號',
                    customInput: PhonePrefixSelect(
                      onChanged: (value) {
                        c.add4StepsForm.phoneprefix = value;
                        c.update(['SenderInfo']);
                      },
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '手機號碼',
                      hintText: '請輸入手機號碼',
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        c.add4StepsForm.phone = value;
                        c.update(['SenderInfo']);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.w),
              FormItem(
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
                      disabled: !c.getCodeAble,
                      text: c.countdown > 0 ? '${c.countdown}s' : '獲取驗證碼',
                      onPressed: () {
                        c.getCode();
                      },
                    ),
                  ),
                ],
                onChanged: (value) {
                  c.add4StepsForm.codePassword = value;
                  c.update(['SenderInfo']);
                },
              ),
              SizedBox(height: 12.w),
              if (c.isNewUser)
                FormItem(
                  label: '推薦碼（選填）',
                  hintText: '請輸入推薦碼',
                  onChanged: (value) {
                    c.add4StepsForm.recommendationcode = value;
                  },
                ),
              if (c.isNewUser)
                AppRow(
                  margin: EdgeInsets.only(top: 12.w),
                  prefix: [
                    AppAssetImage(
                      width: 16.w,
                      margin: EdgeInsets.only(right: 8.w),
                      img: 'icon_cb_${c.isAgreeTerms ? 1 : 0}.png',
                      onTap: () {
                        c.isAgreeTerms = !c.isAgreeTerms;
                        c.update(['SenderInfo']);
                      },
                    ),
                  ],
                  expanded: Row(
                    children: [
                      Text(
                        '同意',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              '/pages/common/rich-txt/index?type=clause');
                        },
                        child: Text(
                          '用户私隱及使用條款',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xff2F8BFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (c.isNewUser)
                AppRow(
                  onTap: () {
                    final v = c.add4StepsForm.acceptnotice;
                    c.add4StepsForm.acceptnotice = v == 1 ? 0 : 1;
                    c.update(['SenderInfo']);
                  },
                  margin: EdgeInsets.only(top: 12.w),
                  prefix: [
                    AppAssetImage(
                      width: 16.w,
                      margin: EdgeInsets.only(right: 8.w),
                      img:
                          'icon_cb_${c.add4StepsForm.acceptnotice == 1 ? 1 : 0}.png',
                    ),
                  ],
                  expanded: Text(
                    '同意收取YO! GIFT推廣電郵以及好友生日提醒',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
