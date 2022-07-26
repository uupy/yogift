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
/// Widget? [expanded]
///
/// Widget? [suffix]
class AppSimpleRow extends StatelessWidget {
  final Widget? expanded;
  final Widget? prefix;
  final Widget? suffix;
  final List<Widget>? children;
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
    this.expanded,
    this.prefix,
    this.suffix,
    this.children,
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
    Widget? _body = expanded;
    List<Widget> _children = children ?? [];

    if (prefix == null && (label?.isNotEmpty ?? false)) {
      _prefix = SizedBox(
        width: labelWidth ?? 50.w,
        child: Text(
          label ?? '',
          style: TextStyle(fontSize: 14.sp),
        ),
      );
    }

    if (expanded == null && (content?.isNotEmpty ?? false)) {
      _body = Text(
        content ?? '',
        style: TextStyle(fontSize: 14.sp),
      );
    }

    if (_prefix != null) {
      _children.insert(0, _prefix);
    }

    if (_body != null) {
      _children.add(Expanded(child: _body));
    }

    if (suffix != null) {
      _children.add(suffix!);
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
        children: _children,
      ),
    );
  }
}
