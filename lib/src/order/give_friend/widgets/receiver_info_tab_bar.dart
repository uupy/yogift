import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class ReceiverInfoTabBar extends StatelessWidget {
  final List<String> items;
  final int? current;
  final Function(int index)? onTap;

  const ReceiverInfoTabBar({
    Key? key,
    required this.items,
    this.current,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.w,
      margin: EdgeInsets.only(top: 16.w, bottom: 8.w),
      child: Row(
        children: items.asMap().keys.map((index) {
          final item = items[index];
          final isActive = current == index;

          return GestureDetector(
            onTap: () {
              onTap?.call(index);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: EdgeInsets.only(right: 16.w),
              child: Row(
                children: [
                  AppAssetImage(
                    width: 16.w,
                    margin: EdgeInsets.only(right: 8.w),
                    img: 'icon_cb_${isActive ? 1 : 0}.png',
                  ),
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
