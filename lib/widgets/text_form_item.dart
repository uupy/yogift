import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormItem extends StatelessWidget {
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
  final Widget? child;
  final Widget? customInput;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function()? onIconTap;

  const TextFormItem({
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
    this.child,
    this.customInput,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.validator,
    this.onChanged,
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
          child ?? buildInput(),
        ],
      );
    }
    return buildInput();
  }

  Widget buildInput() {
    return customInput ??
        TextFormField(
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
            contentPadding:
                contentPadding ?? EdgeInsets.symmetric(horizontal: 10.w),
            constraints: BoxConstraints(
              minHeight: height ?? 44.w,
            ),
            fillColor: backgroundColor ?? const Color(0xfff5f5f5),
            filled: true,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints ??
                BoxConstraints(
                  maxWidth: 14.w,
                ),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            errorBorder: buildBorder(const Color(0xffff3b30)),
            focusedErrorBorder: buildBorder(const Color(0xffff3b30)),
          ),
          onChanged: onChanged,
          onTap: onTap,
          validator: validator,
        );
  }

  OutlineInputBorder buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(radius ?? Radius.circular(8.r)),
      borderSide: BorderSide(
        color: color ?? backgroundColor ?? const Color(0xfff5f5f5),
        width: 1,
      ),
    );
  }
}
