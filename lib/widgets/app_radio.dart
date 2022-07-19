import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class AppRadio {
  final String? label;
  final dynamic value;
  final Widget? child;
  final Widget Function(bool selected)? builder;

  AppRadio({
    this.label,
    this.value,
    this.child,
    this.builder,
  }) : assert((label != null || child != null) && value != null);
}

class AppRadioGroup extends StatefulWidget {
  final List<AppRadio>? items;
  final Color? color;
  final Color? labelColor;
  final Color? selectedColor;
  final Color? selectedLabelColor;
  final dynamic value;
  final bool cancelAble;
  final Function(dynamic value, int index)? onChanged;

  const AppRadioGroup({
    Key? key,
    this.items,
    this.value,
    this.onChanged,
    this.color,
    this.selectedColor,
    this.labelColor,
    this.selectedLabelColor,
    this.cancelAble = false,
  })  : assert(items != null),
        super(key: key);
  @override
  createState() => _AppRadioGroup();
}

class _AppRadioGroup extends State<AppRadioGroup> {
  dynamic currentValue;

  @override
  void initState() {
    currentValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AppRadio> items = widget.items ?? [];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.w,
      children: [
        ...items.asMap().keys.map((index) {
          final item = items[index];
          Color background = widget.color ?? Colors.white;
          Color borderColor =
              widget.color ?? const Color.fromRGBO(203, 203, 203, 0.4);
          Color labelColor =
              widget.labelColor ?? const Color.fromRGBO(0, 0, 0, 0.6);

          if (currentValue == item.value) {
            background = widget.selectedColor ?? AppTheme.primaryColor;
            borderColor = widget.selectedColor ?? AppTheme.primaryColor;
            labelColor =
                widget.selectedLabelColor ?? const Color.fromRGBO(0, 0, 0, 0.9);
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                if (widget.cancelAble && currentValue == item.value) {
                  currentValue = null;
                } else {
                  currentValue = item.value;
                }
                widget.onChanged?.call(
                  currentValue,
                  currentValue == null ? -1 : index,
                );
              });
            },
            child: item.builder == null
                ? buildItem(
                    background: background,
                    borderColor: borderColor,
                    labelColor: labelColor,
                    child: item.child,
                    label: item.label,
                  )
                : item.builder!.call(currentValue == item.value),
          );
        }).toList(),
      ],
    );
  }

  Widget buildItem({
    Color? background,
    Color? borderColor,
    Color? labelColor,
    Widget? child,
    String? label,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 7.h, 10.w, 7.h),
      constraints: BoxConstraints(
        minWidth: 72.w,
        // maxWidth: 110.w,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 0.5,
        ),
      ),
      child: child ??
          Text(
            label ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: labelColor,
            ),
          ),
    );
  }
}
