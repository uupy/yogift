import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/menu_row/menu_row.dart';

class AccountSettingMenuRow extends StatelessWidget {
  final String label;
  final String? content;
  final bool showBottomBorder;
  final Function()? onTap;

  const AccountSettingMenuRow(
      {Key? key,
      required this.label,
      this.content,
      this.showBottomBorder = true,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(0, 0, 0, 0.9);
    String text = content ?? '';

    if (text.isEmpty) {
      text = '現在填寫';
      textColor = const Color.fromRGBO(0, 0, 0, 0.4);
    }

    return MenuRow(
      label: label,
      showBottomBorder: showBottomBorder,
      suffix: Container(
        margin: EdgeInsets.only(right: 8.w),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
