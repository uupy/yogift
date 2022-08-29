import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class OrderGreetingCard extends StatelessWidget {
  final String? backgroundImage;
  final String? msg;
  final String? senderName;

  const OrderGreetingCard({
    Key? key,
    this.backgroundImage,
    this.msg,
    this.senderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          height: 200.w,
          radius: 20.w,
          url: backgroundImage,
        ),
        SizedBox(
          height: 200.w,
          child: Center(
            child: Text(
              msg ?? '',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0, 2.w),
                    blurRadius: 4.w,
                    color: const Color.fromRGBO(0, 0, 0, 0.65),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24.w,
          left: 36.w,
          child: Text(
            '贈送者：${senderName ?? ''}',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 2.w),
                  blurRadius: 4.w,
                  color: const Color.fromRGBO(0, 0, 0, 0.65),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
