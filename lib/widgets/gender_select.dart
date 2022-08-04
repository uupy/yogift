import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class GenderSelect extends StatefulWidget {
  final int value;
  final Function(int value)? onChanged;

  const GenderSelect({
    Key? key,
    this.value = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  _GenderSelectState createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  @override
  Widget build(BuildContext context) {
    final value = widget.value;

    return Row(
      children: [
        buildItem(
          text: '男',
          icon: 'icon_male_${value == 1 ? 1 : 0}.png',
          color: value == 1 ? const Color(0xff2f8bff) : null,
          onTap: () {
            if (value != 1) {
              widget.onChanged?.call(1);
            }
          },
        ),
        SizedBox(width: 20.w),
        buildItem(
          text: '女',
          icon: 'icon_female_${value == 2 ? 1 : 0}.png',
          color: value == 2 ? const Color(0xfff96161) : null,
          onTap: () {
            if (value != 2) {
              widget.onChanged?.call(2);
            }
          },
        ),
      ],
    );
  }

  Widget buildItem({
    String text = '',
    String icon = '',
    Color? color = const Color(0xff2f8bff),
    Function()? onTap,
  }) {
    return Expanded(
      child: AppSimpleRow(
        onTap: onTap,
        height: 44.w,
        radius: 8.r,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        border: Border.all(
          color: color ?? const Color(0xffcccccc),
        ),
        children: [
          AppAssetImage(
            width: 17.w,
            margin: EdgeInsets.only(right: 4.w),
            img: icon,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: color ?? const Color(0xffcccccc),
            ),
          ),
        ],
      ),
    );
  }
}
