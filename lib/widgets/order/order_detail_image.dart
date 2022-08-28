import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/goods/goods_sending_tag.dart';

class OrderDetailImage extends StatelessWidget {
  final String url;
  final int? sendingMethod;
  final Function()? onTap;

  const OrderDetailImage({
    Key? key,
    required this.url,
    this.sendingMethod,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          AppImage(
            width: 90.w,
            height: 90.w,
            url: url,
            color: Colors.white,
            radius: 12.r,
            border: Border.all(
              width: 0.5,
              color: const Color(0xffe6e6e6),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GoodsSendingTag(
              method: sendingMethod ?? 1,
            ),
          ),
        ],
      ),
    );
  }
}
