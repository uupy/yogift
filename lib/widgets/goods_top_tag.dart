import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class GoodsTopTag extends StatelessWidget {
  final int index;

  const GoodsTopTag({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppImage(
      url: 'lib/assets/images/icon_rank${index > 3 ? 2 : 1}.png',
      color: Colors.transparent,
      width: 28.w,
      height: 34.w,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 4.w),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: index > 3 ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
