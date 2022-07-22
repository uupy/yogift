import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class EmptyBox extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const EmptyBox({
    Key? key,
    this.width,
    this.height,
    this.text,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 50.w),
      child: Column(
        children: [
          const AppAssetImage(
            img: 'img_no_data.png',
          ),
          Container(
            margin: EdgeInsets.only(top: 20.w),
            child: Center(
              child: Text(
                '暫無數據',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
