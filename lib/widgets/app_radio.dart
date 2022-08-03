import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class AppRadio {
  final String? label;
  final dynamic value;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Widget Function(bool selected)? builder;

  AppRadio({
    this.label,
    this.value,
    this.child,
    this.padding,
    this.builder,
  }) : assert((label != null || child != null) && value != null);
}

class AppRadioGroup extends StatefulWidget {
  final List<AppRadio>? items;
  final Color? color;
  final Color? labelColor;
  final Color? selectedColor;
  final Color? selectedLabelColor;
  final double? spacing;
  final double? runSpacing;
  final EdgeInsetsGeometry? itemPadding;
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
    this.spacing,
    this.runSpacing,
    this.itemPadding,
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
  void didUpdateWidget(covariant AppRadioGroup oldWidget) {
    setState(() {
      currentValue = widget.value;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<AppRadio> items = widget.items ?? [];

    return Wrap(
      spacing: widget.spacing ?? 8.w,
      runSpacing: widget.runSpacing ?? 8.w,
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
                dynamic _value;
                if (widget.cancelAble && currentValue == item.value) {
                  _value = null;
                } else {
                  _value = item.value;
                }
                if (currentValue != _value) {
                  currentValue = _value;
                  widget.onChanged?.call(_value, _value == null ? -1 : index);
                }
              });
            },
            child: item.builder == null
                ? buildItem(
                    background: background,
                    borderColor: borderColor,
                    labelColor: labelColor,
                    child: item.child,
                    label: item.label,
                    padding: item.padding ?? widget.itemPadding,
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
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
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
