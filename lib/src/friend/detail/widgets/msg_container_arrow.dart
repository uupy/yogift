import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsgContainerArrow extends StatelessWidget {
  final Color? color;
  final bool isSelf;

  const MsgContainerArrow({Key? key, this.color, this.isSelf = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.w,
      left: isSelf ? null : 0,
      right: isSelf ? 0 : null,
      child: Transform.rotate(
        angle: math.pi * 45 / 180,
        child: Container(
          width: 8.w,
          height: 8.w,
          color: color,
        ),
      ),
    );
  }
}
