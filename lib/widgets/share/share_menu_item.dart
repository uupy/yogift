import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class ShareMenuItem extends StatelessWidget {
  final String img;
  final String name;
  final Function()? onTap;

  const ShareMenuItem({
    Key? key,
    required this.img,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssetImage(
            width: 40.w,
            height: 40.w,
            margin: EdgeInsets.only(bottom: 8.w),
            img: img,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
