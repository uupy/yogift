import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormItem extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? initialValue;
  final bool? autofocus;
  final bool? readOnly;
  final bool? obscureText;
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
  final Widget? customInput;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;
  final void Function()? onTap;
  final void Function()? onIconTap;

  const FormItem({
    Key? key,
    this.label,
    this.hintText,
    this.initialValue,
    this.autofocus,
    this.readOnly,
    this.obscureText,
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
    this.customInput,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (label?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
              )
            ],
          ),
          SizedBox(height: 8.w),
          buildInput(),
        ],
      );
    }
    return buildInput();
  }

  Widget buildInput() {
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
            child: customInput ??
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  textAlign: TextAlign.left,
                  textInputAction: textInputAction,
                  autofocus: autofocus ?? false,
                  readOnly: readOnly ?? false,
                  obscureText: obscureText ?? false,
                  cursorColor: const Color.fromRGBO(0, 0, 0, 0.9),
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
