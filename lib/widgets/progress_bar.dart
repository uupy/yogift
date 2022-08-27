import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class ProgressBar extends StatelessWidget {
  final int total;
  final int completed;
  final String label;
  final String unit;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const ProgressBar({
    Key? key,
    required this.total,
    required this.completed,
    this.label = '捐贈進度',
    this.unit = '件',
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _total = total <= 0 ? 1 : total;
    final widthFactor = completed / _total;

    return AppSimpleRow(
      onTap: onTap,
      margin: margin ?? EdgeInsets.only(top: 10.w),
      prefix: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color.fromRGBO(0, 0, 0, 0.4),
        ),
      ),
      expanded: Container(
        height: 5.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(125, 200, 120, 0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(2.w),
          ),
        ),
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff7dc878),
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
            ),
          ),
        ),
      ),
      suffix: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 11.sp,
            color: const Color.fromRGBO(0, 0, 0, 0.4),
          ),
          children: [
            TextSpan(
              text: '$completed',
              style: TextStyle(
                fontSize: 18.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: '/$total$unit'),
          ],
        ),
      ),
    );
  }
}
