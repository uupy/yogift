import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:yo_gift/widgets/flutter_datetime_picker/src/datetime_picker_theme.dart';
import 'package:yo_gift/widgets/flutter_datetime_picker/src/i18n_model.dart';

import 'menu_row.dart';

class BirthdayMenuRow extends StatefulWidget {
  final String? value;
  final Function(String value)? onChanged;

  const BirthdayMenuRow({Key? key, this.value, this.onChanged})
      : super(key: key);

  @override
  _BirthdayMenuRowState createState() => _BirthdayMenuRowState();
}

class _BirthdayMenuRowState extends State<BirthdayMenuRow> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AccountSettingMenuRow(
      label: '出生日期',
      content: widget.value,
      onTap: () {
        DatePicker.showDatePicker(
          Get.context!,
          locale: LocaleType.zh,
          minTime: DateTime.utc(1920),
          maxTime: DateTime.now(),
          currentTime: widget.value != null
              ? DateTime.tryParse(widget.value!)
              : DateTime.now(),
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
          onConfirm: (datetime) async {
            final val = CommonUtils.formatDate(datetime, 'yyyy-MM-dd');
            if (val != widget.value) {
              await UserService.updateBirthday(val);
            }
            widget.onChanged?.call(val);
          },
        );
      },
    );
  }
}
