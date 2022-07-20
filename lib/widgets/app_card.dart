import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const AppCard({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.radius,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8.r,
          ),
        ],
      ),
      child: child,
    );
  }
}
