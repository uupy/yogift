import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class GenderSelect extends StatelessWidget {
  final int value;
  final Function(int value)? onChanged;

  const GenderSelect({
    Key? key,
    this.value = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildItem(
          text: '男',
          icon: 'icon_male_${value == 1 ? 1 : 0}.png',
          onTap: () {
            if (value != 1) {
              onChanged?.call(1);
            }
          },
        ),
        SizedBox(width: 20.w),
        buildItem(
          text: '女',
          icon: 'icon_female_${value == 2 ? 1 : 0}.png',
          activeColor: const Color(0xfff96161),
          onTap: () {
            if (value != 2) {
              onChanged?.call(2);
            }
          },
        ),
      ],
    );
  }

  Widget buildItem({
    String text = '',
    String icon = '',
    Color activeColor = const Color(0xff2f8bff),
    Function()? onTap,
  }) {
    return Expanded(
      child: AppSimpleRow(
        onTap: onTap,
        height: 44.w,
        radius: 8.r,
        border: Border.all(
          color: value == 1 ? activeColor : const Color(0xffcccccc),
        ),
        children: [
          AppAssetImage(
            width: 17.w,
            img: icon,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: value == 1 ? activeColor : const Color(0xffcccccc),
            ),
          ),
        ],
      ),
    );
  }
}
