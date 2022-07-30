import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Widget? child;
  final bool block;
  final bool round;
  final bool disabled;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Size? fixedSize;
  final Size? minimumSize;
  final Size? maximumSize;
  final double? height;
  final double? fontSize;
  final double? radius;
  final Function()? onPressed;

  const AppButton({
    Key? key,
    this.text,
    this.style,
    this.child,
    this.block = false,
    this.round = true,
    this.disabled = false,
    this.backgroundColor = AppTheme.primaryColor,
    this.borderColor = AppTheme.primaryColor,
    this.padding,
    this.fixedSize,
    this.minimumSize,
    this.maximumSize,
    this.height,
    this.fontSize,
    this.radius,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = height ?? 44.w;
    Size? _fixedSize = fixedSize;
    Size? _minimumSize = minimumSize;
    double _radius = radius ?? 4.r;
    Color? _background = backgroundColor;
    Color? _borderColor = borderColor;
    Color? _textColor = const Color.fromRGBO(0, 0, 0, 0.9);

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

    if (disabled) {
      _background = const Color(0xffe6e6e6);
      _borderColor = const Color(0xffe6e6e6);
      _textColor = const Color.fromRGBO(0, 0, 0, 0.26);
    }

    return ElevatedButton(
      onPressed: () {
        if (disabled) return;
        onPressed?.call();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          _background,
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
        side: MaterialStateProperty.all(
          BorderSide(
            color: _borderColor ?? AppTheme.primaryColor,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: child ??
            Text(
              text ?? 'button',
              style: style ??
                  TextStyle(
                    fontSize: fontSize ?? 14.sp,
                    color: _textColor,
                  ),
            ),
      ),
    );
  }
}
