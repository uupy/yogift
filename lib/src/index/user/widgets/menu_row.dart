import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_row.dart';

class MenuRow extends StatelessWidget {
  final String? icon;
  final String? label;
  final bool arrow;
  final bool showBottomBorder;
  final Function()? onTap;

  const MenuRow({
    Key? key,
    this.icon,
    this.label,
    this.arrow = true,
    this.showBottomBorder = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxBorder? _border;

    if (showBottomBorder) {
      _border = const Border(
        bottom: BorderSide(
          width: 0.5,
          color: Color.fromRGBO(230, 230, 230, 0.5),
        ),
      );
    }

    return AppRow(
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: 18.w),
      mainAxisAlignment: MainAxisAlignment.center,
      border: _border,
      prefix: [
        AppAssetImage(
          img: icon,
          width: 20.w,
          margin: EdgeInsets.only(right: 8.w),
        ),
      ],
      body: Text(
        label ?? '',
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
      suffix: [
        if (arrow)
          AppAssetImage(
            img: 'icon_arrow_right2.png',
            width: 8.w,
          ),
      ],
    );
  }
}
