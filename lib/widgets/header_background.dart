import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class HeaderBackground extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? radius;
  final Widget? child;

  const HeaderBackground({
    Key? key,
    this.color,
    this.height,
    this.radius,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper(radius: radius),
      child: Container(
        height: height ?? 152.h,
        color: color ?? AppTheme.primaryColor,
        child: child,
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  final double? radius;

  const BackgroundClipper({this.radius});

  @override
  Path getClip(Size size) {
    double roundnessFactor = radius ?? 66.h;
    Path path = Path();

    //移动到A点
    path.moveTo(0, 0);
    //画直线到B点 同时也充当 下一个二阶贝塞尔曲线 的起点
    path.lineTo(0, size.height - roundnessFactor);

    //二阶贝塞尔曲线 只有一个控制点
    // 控制点 C (0, size.height)
    // 终点 D (roundnessFactor, size.height)
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - roundnessFactor);

    //二阶贝塞尔曲线 只有一个控制点
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
