import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double? radius;
  final double? blurRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final bool showBorder;
  final HitTestBehavior? behavior;
  final Function()? onTap;

  const AppCard({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.radius,
    this.blurRadius,
    this.margin,
    this.padding,
    this.border,
    this.showBorder = true,
    this.behavior,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: behavior ?? HitTestBehavior.opaque,
        child: buildContainer(),
      );
    }

    return buildContainer();
  }

  Widget buildContainer() {
    BoxBorder? _border = border;

    if (showBorder && border == null) {
      _border = Border.all(
        width: 1,
        color: const Color(0xfff5f5f5),
      );
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 20.r),
        ),
        border: _border,
        boxShadow: blurRadius == 0
            ? null
            : [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.08),
                  blurRadius: blurRadius ?? 6.r,
                ),
              ],
      ),
      child: child,
    );
  }
}
