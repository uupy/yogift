import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_row.dart';

class ModuleTitle extends StatelessWidget {
  final String? textCn;
  final String? textEn;
  final Widget? suffix;
  final String? suffixAssetImg;
  final Color? textCnColor;
  final Color? textEnColor;
  final Color? background;
  final EdgeInsetsGeometry? padding;

  const ModuleTitle({
    Key? key,
    this.textCn,
    this.textEn,
    this.suffix,
    this.suffixAssetImg,
    this.background = Colors.transparent,
    this.textCnColor = const Color.fromRGBO(0, 0, 0, 0.9),
    this.textEnColor = const Color.fromRGBO(255, 225, 0, .4),
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppRow(
      color: background,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 14.w,
          ),
      expanded: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Text(
              textEn ?? '',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: textEnColor,
              ),
            ),
          ),
          Text(
            textCn ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: textCnColor,
            ),
          ),
        ],
      ),
      suffix: [
        suffix ??
            AppAssetImage(
              img: suffixAssetImg,
              width: 50.w,
            ),
      ],
    );
  }
}
