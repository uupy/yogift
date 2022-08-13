import 'dart:math' as math;

import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_row.dart';
import 'package:yo_gift/widgets/flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yo_gift/widgets/flutter_datetime_picker/src/datetime_picker_theme.dart';
import 'package:yo_gift/widgets/flutter_datetime_picker/src/i18n_model.dart';
import 'package:yo_gift/widgets/form_item.dart';
import 'package:yo_gift/widgets/gender_select.dart';
import 'package:yo_gift/widgets/text_form_item.dart';

import '../register_controller.dart';

class RegisterThirdStepForm extends StatelessWidget {
  RegisterThirdStepForm({Key? key}) : super(key: key);

  final birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      id: 'ThirdStepForm',
      builder: (c) {
        return Form(
          key: c.updateFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '填補個人信息讓好友知道你的生日，YO！提醒送禮！',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 20.w),
              FormItem(
                label: '暱稱（選填）',
                hintText: '請輸入暱稱',
                onChanged: (value) {
                  c.updateFormData.nickname = value;
                  c.update(['ThirdStepForm']);
                },
              ),
              SizedBox(height: 12.w),
              FormItem(
                label: '生日（不會公開年份）',
                hintText: '請選擇生日',
                readOnly: true,
                controller: birthdayController,
                suffixIcon: Transform.rotate(
                  angle: -math.pi / 2,
                  child: AppAssetImage(
                    width: 12.w,
                    img: 'icon_arrow_down.png',
                  ),
                ),
                onTap: () {
                  DatePicker.showDatePicker(
                    Get.context!,
                    locale: LocaleType.zh,
                    minTime: DateTime.utc(1920),
                    maxTime: DateTime.now(),
                    currentTime: DateTime.now(),
                    theme: DatePickerTheme(
                      headerHeight: 54.w,
                      footerHeight: 64.w,
                      backgroundColor: Colors.transparent,
                    ),
                    header: Container(
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
                                '選擇生日日期',
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
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                    footerBuilder: (onPressed) {
                      return Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
                        child: AppButton(
                          text: '確定',
                          onPressed: onPressed,
                        ),
                      );
                    },
                    onConfirm: (datetime) {
                      final val =
                          CommonUtils.formatDate(datetime, 'yyyy-MM-dd');
                      logger.i('val: $val');
                      birthdayController.text = val;
                      c.updateFormData.birthday = val;
                      c.update(['ThirdStepForm']);
                    },
                  );
                },
              ),
              SizedBox(height: 12.w),
              FormItem(
                label: '性别',
                child: GenderSelect(
                  value: c.updateFormData.gener ?? 1,
                  onChanged: (value) {
                    c.updateFormData.gener = value;
                    c.update(['ThirdStepForm']);
                  },
                ),
              ),
              SizedBox(height: 12.w),
              TextFormItem(
                label: '郵件（選填）',
                hintText: '請輸入郵件',
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return null;
                  } else if (!CommonUtils.isEmail(value)) {
                    return '請輸入正確的郵箱格式';
                  }
                },
                onChanged: (value) {
                  c.updateFormData.email = value;
                  c.updateFormKey.currentState?.validate();
                },
              ),
              AppRow(
                margin: EdgeInsets.only(top: 32.w),
                prefix: [
                  AppAssetImage(
                    width: 16.w,
                    margin: EdgeInsets.only(right: 6.w),
                    img: 'icon_cb_${c.isAgreeTerms ? 1 : 0}.png',
                    onTap: () {
                      c.isAgreeTerms = !c.isAgreeTerms;
                      c.update(['ThirdStepForm']);
                    },
                  ),
                ],
                expanded: Row(
                  children: [
                    Text(
                      '同意',
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        color: const Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/pages/common/rich-txt/index?type=clause');
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
              AppRow(
                onTap: () {
                  final v = c.updateFormData.acceptnotice;
                  c.updateFormData.acceptnotice = v == 1 ? 0 : 1;
                  c.update(['ThirdStepForm']);
                },
                margin: EdgeInsets.only(top: 12.w),
                prefix: [
                  AppAssetImage(
                    width: 16.w,
                    margin: EdgeInsets.only(right: 6.w),
                    img:
                        'icon_cb_${c.updateFormData.acceptnotice == 1 ? 1 : 0}.png',
                  ),
                ],
                expanded: Text(
                  '同意收取YO! GIFT推廣電郵以及好友生日提醒',
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 28.w),
                child: AppButton(
                  disabled: !c.updateAble,
                  text: c.submitting.value ? '提交中...' : '確定',
                  onPressed: () {
                    c.onSubmitUpdate();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.w),
                child: AppButton(
                  text: '跳過',
                  backgroundColor: const Color(0xfffffdeb),
                  onPressed: () {
                    c.goBackHome();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
