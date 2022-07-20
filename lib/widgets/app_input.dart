import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final bool? autofocus;
  final bool? readOnly;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Radius? radius;
  final List<Widget>? actions;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final void Function()? onTap;
  final void Function()? onIconTap;

  const AppInput({
    Key? key,
    this.hintText,
    this.initialValue,
    this.autofocus,
    this.readOnly,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.contentPadding,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.border,
    this.radius,
    this.actions,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 46.w,
      margin: margin,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xfff5f5f5),
        borderRadius: BorderRadius.all(radius ?? Radius.circular(8.r)),
        border: border,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textAlign: TextAlign.left,
              textInputAction: textInputAction,
              autofocus: autofocus ?? false,
              readOnly: readOnly ?? false,
              decoration: InputDecoration(
                hintText: hintText ?? '请输入关键词',
                hintStyle: const TextStyle(color: Color(0xff969696)),
                contentPadding: contentPadding ?? EdgeInsets.zero,
                isCollapsed: true,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              onTap: onTap,
            ),
          ),
          if (icon != null)
            GestureDetector(
              onTap: onIconTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Icon(
                  icon,
                  color: iconColor ?? const Color(0xff969696),
                  size: 18.w,
                ),
              ),
            ),
          ...(actions ?? []),
        ],
      ),
    );
  }
}
