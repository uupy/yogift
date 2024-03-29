import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final bool? autofocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final bool showCounter;
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
  final Color? cursorColor;
  final BoxBorder? border;
  final Radius? radius;
  final List<Widget>? prefix;
  final List<Widget>? actions;
  final TextAlign textAlign;
  final TextStyle? style;
  final int? maxLength;
  final int? maxLines;
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
    this.showCounter = false,
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
    this.cursorColor,
    this.border,
    this.radius,
    this.prefix,
    this.actions,
    this.textAlign = TextAlign.left,
    this.style,
    this.maxLength,
    this.maxLines,
    this.enableSuggestions,
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
          ...(prefix ?? []),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              style: style,
              textAlign: textAlign,
              textInputAction: textInputAction,
              maxLength: maxLength,
              maxLines: maxLines,
              enableSuggestions: enableSuggestions ?? true,
              autofocus: autofocus ?? false,
              readOnly: readOnly ?? false,
              cursorColor: cursorColor ?? const Color.fromRGBO(0, 0, 0, 0.9),
              decoration: InputDecoration(
                hintText: hintText ?? '请输入关键词',
                hintStyle: const TextStyle(color: Color(0xff969696)),
                contentPadding: contentPadding ?? EdgeInsets.zero,
                isCollapsed: true,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                counterText: showCounter ? null : '',
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
