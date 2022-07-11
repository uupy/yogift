import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormItem extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final Widget? labelSuffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final String? initialValue;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Color? inputBorderColor;
  final Widget? custom;
  final int? maxLines;

  const FormItem({
    Key? key,
    this.label,
    this.labelStyle,
    this.labelSuffix,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.style,
    this.hintStyle,
    this.hintText,
    this.initialValue,
    this.margin,
    this.padding,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.validator,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.obscureText = false,
    this.contentPadding,
    this.width,
    this.height,
    this.decoration,
    this.inputBorderColor,
    this.custom,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.only(bottom: 8.h),
      padding: padding,
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label ?? '',
                  style: labelStyle ??
                      TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.contentColor,
                      ),
                ),
              ),
              if (labelSuffix != null) labelSuffix!
            ],
          ),
          custom ??
              TextFormField(
                style: style,
                initialValue: initialValue,
                controller: controller,
                focusNode: focusNode,
                keyboardType: keyboardType,
                textAlign: TextAlign.left,
                readOnly: readOnly,
                obscureText: obscureText,
                maxLines: maxLines,
                decoration: InputDecoration(
                  prefix: prefix,
                  prefixIcon: prefixIcon,
                  prefixIconConstraints: const BoxConstraints(),
                  suffix: suffix,
                  suffixIcon: suffixIcon,
                  suffixIconConstraints: const BoxConstraints(),
                  hintText: hintText,
                  hintStyle:
                      hintStyle ?? const TextStyle(color: Color(0xff969696)),
                  contentPadding:
                      contentPadding ?? EdgeInsets.symmetric(vertical: 8.w),
                  isCollapsed: true,
                  enabledBorder: buildBorder(color: inputBorderColor),
                  focusedBorder: buildBorder(color: inputBorderColor),
                  errorBorder: buildBorder(
                      color: inputBorderColor ?? AppTheme.alarmColor),
                  focusedErrorBorder: buildBorder(
                      color: inputBorderColor ?? AppTheme.borderColor),
                ),
                onChanged: onChanged,
                onSaved: onSaved,
                onTap: onTap,
                validator: validator,
              ),
        ],
      ),
    );
  }

  UnderlineInputBorder buildBorder({Color? color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color ?? const Color(0xffededed),
        width: 1,
      ),
    );
  }
}
