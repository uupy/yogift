import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Widget? child;
  final bool block;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final Function()? onPressed;

  const AppElevatedButton({
    Key? key,
    this.text,
    this.style,
    this.child,
    this.block = false,
    this.backgroundColor,
    this.padding,
    this.minimumSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          backgroundColor ?? AppTheme.primaryColor,
        ),
        minimumSize: MaterialStateProperty.all(
          minimumSize ?? (block ? Size(double.infinity, 30.h) : Size.zero),
        ),
        padding: MaterialStateProperty.all(
          padding ?? EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
        ),
      ),
      child: child ?? Text(text ?? 'button', style: style),
    );
  }
}
