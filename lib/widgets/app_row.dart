import 'package:flutter/material.dart';

/// AppRow 水平flex布局
///
/// double? [width]
///
/// double? [height]
///
/// EdgeInsetsGeometry? [padding]
///
/// EdgeInsetsGeometry? [margin]
///
/// List<Widget>? [prefix]
///
/// Widget? [body]
///
/// List<Widget>? [suffix]
///
/// void Function()? [onTap]
class AppRow extends StatelessWidget {
  final Widget? body;
  final List<Widget>? prefix;
  final List<Widget>? suffix;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  final double? height;
  final double? radius;
  final Function()? onTap;
  final Function()? onBodyTap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final HitTestBehavior? behavior;

  const AppRow({
    Key? key,
    this.prefix,
    this.body,
    this.suffix,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.radius,
    this.onTap,
    this.onBodyTap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.border,
    this.borderRadius,
    this.behavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return buildContainer();
    }
    return GestureDetector(
      onTap: onTap,
      behavior: behavior ?? HitTestBehavior.opaque,
      child: buildContainer(),
    );
  }

  Widget buildContainer() {
    BorderRadiusGeometry? _borderRadius = borderRadius;
    if (_borderRadius == null && radius != null && radius != 0) {
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
        children: [
          ...(prefix ?? []),
          if (body != null)
            Expanded(
              child: onBodyTap != null
                  ? GestureDetector(
                      onTap: onBodyTap,
                      behavior: HitTestBehavior.opaque,
                      child: body,
                    )
                  : body!,
            ),
          ...(suffix ?? []),
        ],
      ),
    );
  }
}
