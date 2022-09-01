import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const List<Color> colors = [
  Color(0xff66d15f),
  Color(0xff268eff),
  Color(0xffff8d00),
  Color(0xffff2a5d),
];

class AppTag extends StatefulWidget {
  final String? text;
  final Widget? child;
  final Color? color;
  final bool showShape;
  final EdgeInsetsGeometry? padding;

  const AppTag({
    Key? key,
    this.text,
    this.child,
    this.color,
    this.showShape = false,
    this.padding,
  }) : super(key: key);

  @override
  _AppTagState createState() => _AppTagState();
}

class _AppTagState extends State<AppTag> {
  final index = Random().nextInt(3);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: widget.padding ??
              EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.w),
          decoration: BoxDecoration(
            color: widget.color != null
                ? widget.color!.withOpacity(0.1)
                : colors[index].withOpacity(0.1),
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          ),
          child: Text(
            widget.text ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.color ?? colors[index],
              fontSize: 12.sp,
            ),
          ),
        ),
        if (widget.showShape)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
