import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOutlinedButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Widget? child;
  final bool block;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;

  const AppOutlinedButton({
    Key? key,
    this.text,
    this.child,
    this.block = false,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: borderColor ?? AppTheme.primaryColor,
            width: 1,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        minimumSize: MaterialStateProperty.all(
          block ? Size(double.infinity, 30.h) : Size.zero,
        ),
        padding: MaterialStateProperty.all(
          padding ?? EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
        ),
      ),
      child: child ?? Text(text ?? 'button', style: style),
    );
  }
}
