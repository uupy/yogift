import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'tool_bar_filter.dart';
import 'tool_bar_sort.dart';

class GoodsToolBar extends StatefulWidget {
  final int? orderBy;
  final int? sendingMethod;
  final int? total;
  final double? height;
  final Color? buttonBorderColor;
  final EdgeInsetsGeometry? margin;
  final Function(int? value)? onSortChanged;
  final Function(int? value)? onSendingMethodChanged;

  const GoodsToolBar({
    Key? key,
    this.orderBy,
    this.sendingMethod,
    this.total,
    this.height,
    this.buttonBorderColor,
    this.margin,
    this.onSortChanged,
    this.onSendingMethodChanged,
  }) : super(key: key);

  @override
  _GoodsToolBarState createState() => _GoodsToolBarState();
}

class _GoodsToolBarState extends State<GoodsToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: widget.margin ?? EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.w),
      child: Row(
        children: [
          GoodsToolBarSort(
            value: widget.orderBy,
            buttonBorderColor: widget.buttonBorderColor,
            onChanged: (index) {
              final idx = index + 1;
              int? value = widget.orderBy != idx ? idx : null;
              widget.onSortChanged?.call(value);
            },
          ),
          SizedBox(width: 6.w),
          GoodsToolBarFilter(
            value: widget.sendingMethod,
            buttonBorderColor: widget.buttonBorderColor,
            onChanged: (index) {
              final idx = index + 1;
              int? value = widget.sendingMethod != idx ? idx : null;
              widget.onSendingMethodChanged?.call(value);
            },
          ),
          Expanded(
            child: Text(
              '已顯示：${widget.total ?? 0}個禮物',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
