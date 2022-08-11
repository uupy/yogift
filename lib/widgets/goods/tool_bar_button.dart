import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/animated_button.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class GoodsToolBarButton extends StatelessWidget {
  final String? text;
  final String? icon;
  final Color? borderColor;
  final Function()? onPressed;
  const GoodsToolBarButton({
    Key? key,
    this.text,
    this.icon,
    this.borderColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      color: Colors.white,
      borderColor: borderColor ?? Colors.white,
      width: 78.w,
      height: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssetImage(
            width: 16.w,
            img: icon,
          ),
          Text(
            text ?? '',
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
