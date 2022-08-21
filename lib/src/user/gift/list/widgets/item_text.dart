import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemText extends StatelessWidget {
  final String? label;
  final String? content;
  const ItemText({Key? key, this.label, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 12.sp,
        ),
        children: [
          TextSpan(
            text: label ?? '',
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
          TextSpan(
            text: content ?? '',
          ),
        ],
      ),
    );
  }
}
