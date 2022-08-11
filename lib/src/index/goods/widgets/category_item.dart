import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final int listLength;
  final String? imgUrl;
  final String? name;
  final Function()? onTap;

  const CategoryItem(
      {Key? key,
      this.index = 0,
      this.listLength = 0,
      this.imgUrl,
      this.name,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry? margin = EdgeInsets.symmetric(horizontal: 6.w);

    if (index == 0) {
      margin = EdgeInsets.fromLTRB(20.w, 0, 6.w, 0);
    } else if (index == listLength - 1) {
      margin = EdgeInsets.fromLTRB(6.w, 0, 20.w, 0);
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: margin,
        child: Column(
          children: [
            AppImage(
              width: 78.w,
              height: 78.w,
              radius: 18.w,
              margin: EdgeInsets.only(bottom: 6.w),
              url: imgUrl,
            ),
            Text(
              name ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
