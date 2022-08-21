import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMsgContainer extends StatelessWidget {
  final Color? color;
  final String? text;

  const TextMsgContainer({Key? key, this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(4.w),
        ),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
