import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import '../detail_controller.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      id: 'GreetingCard',
      builder: (c) {
        final backgroundImage = c.detail?.greetingcardBigImg ?? '';
        final msg = c.detail?.msgGive ?? '';
        final nickName = c.detail?.nickName ?? '';

        if (!c.isGifted) {
          return Container();
        }

        return AppImage(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          height: 200.w,
          radius: 20.w,
          url: backgroundImage,
          child: Stack(
            children: [
              Center(
                child: Text(
                  msg,
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
              Positioned(
                bottom: 20.w,
                left: 16.w,
                child: Text(
                  '贈送者：$nickName',
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
          ),
        );
      },
    );
  }
}
