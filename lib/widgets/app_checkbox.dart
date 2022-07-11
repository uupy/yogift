import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckbox extends StatefulWidget {
  final String? label;
  final bool? value;
  final Color? activeColor;
  final double? iconSize;
  final double? fontSize;
  final Function(bool value)? onChanged;

  const AppCheckbox({
    Key? key,
    this.label,
    this.value,
    this.activeColor,
    this.iconSize,
    this.fontSize,
    this.onChanged,
  }) : super(key: key);

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isChecked = false;
  Color activeColor = AppTheme.primaryColor;

  @override
  void initState() {
    activeColor = widget.activeColor ?? AppTheme.primaryColor;
    setState(() {});
    super.initState();
  }

  void onChange() {
    setState(() {
      isChecked = !isChecked;
      widget.onChanged?.call(isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.label ?? '';

    if (widget.value != null) {
      isChecked = widget.value!;
    }

    if (label.isNotEmpty) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onChange,
        child: Row(
          children: [
            buildIcon(),
            SizedBox(width: 5.w),
            buildText(label),
          ],
        ),
      );
    }

    return IconButton(
      onPressed: onChange,
      icon: buildIcon(),
    );
  }

  Widget buildIcon() {
    return Icon(
      isChecked ? IconFont.icon_checked : IconFont.icon_unchecked,
      color: isChecked ? activeColor : AppTheme.contentColor,
      size: widget.iconSize ?? 20.sp,
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: isChecked ? activeColor : AppTheme.contentColor,
        fontSize: widget.fontSize ?? 14.sp,
      ),
    );
  }
}
