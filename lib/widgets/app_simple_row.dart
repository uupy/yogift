import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppSimpleRow 水平flex布局
///
/// double? [width]
///
/// double? [height]
///
/// EdgeInsetsGeometry? [padding]
///
/// EdgeInsetsGeometry? [margin]
///
/// Widget? [prefix]
///
/// Widget? [body]
///
/// Widget? [suffix]
class AppSimpleRow extends StatelessWidget {
  final Widget? body;
  final Widget? prefix;
  final Widget? suffix;
  final String? label;
  final String? content;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  final double? height;
  final double? radius;
  final double? labelWidth;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;

  const AppSimpleRow({
    Key? key,
    this.body,
    this.prefix,
    this.suffix,
    this.label,
    this.content,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.radius = 4,
    this.labelWidth,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.border,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry? _borderRadius = borderRadius;
    Widget? _prefix = prefix;
    Widget? _body = body;
    List<Widget> children = [];

    if (prefix == null && (label?.isNotEmpty ?? false)) {
      _prefix = SizedBox(
        width: labelWidth ?? 50.w,
        child: Text(
          label ?? '',
          style: TextStyle(fontSize: 14.sp),
        ),
      );
    }
    if (body == null && (content?.isNotEmpty ?? false)) {
      _body = Text(
        content ?? '',
        style: TextStyle(fontSize: 14.sp),
      );
    }

    if (_prefix != null) {
      children.add(_prefix);
    }

    if (_body != null) {
      children.add(Expanded(child: _body));
    }

    if (suffix != null) {
      children.add(suffix!);
    }

    if (_borderRadius == null && ((radius ?? 0) > 0)) {
      _borderRadius = BorderRadius.all(
        Radius.circular(radius!),
      );
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: border,
        borderRadius: _borderRadius,
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}
