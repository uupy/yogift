import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Widget? child;
  final bool block;
  final bool round;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Size? fixedSize;
  final Size? minimumSize;
  final Size? maximumSize;
  final double? height;
  final Function()? onPressed;

  const AppButton({
    Key? key,
    this.text,
    this.style,
    this.child,
    this.block = false,
    this.round = true,
    this.backgroundColor,
    this.padding,
    this.fixedSize,
    this.minimumSize,
    this.maximumSize,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = height ?? 44.h;
    Size? _fixedSize = fixedSize;
    Size? _minimumSize = minimumSize;
    double _radius = 4.r;

    if (fixedSize == null) {
      if (block) {
        _fixedSize = Size(double.maxFinite, _height);
      } else if (minimumSize == null) {
        _minimumSize = Size(0, _height);
      }
    }

    if (round) {
      if (_fixedSize != null) {
        _radius = _fixedSize.height;
      } else if (maximumSize != null) {
        _radius = maximumSize!.height;
      } else if (minimumSize != null) {
        _radius = minimumSize!.height;
      } else {
        _radius = _height;
      }
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ?? AppTheme.primaryColor,
        ),
        fixedSize: MaterialStateProperty.all(_fixedSize),
        minimumSize: MaterialStateProperty.all(_minimumSize),
        maximumSize: MaterialStateProperty.all(maximumSize),
        padding: MaterialStateProperty.all(
          padding ?? EdgeInsets.symmetric(horizontal: 10.w),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      child: Center(
        child: child ??
            Text(
              text ?? 'button',
              style: style ??
                  TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromRGBO(0, 0, 0, 0.9),
                  ),
            ),
      ),
    );
  }
}
