import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class GoodsMsgContainer extends StatelessWidget {
  final Color? color;
  final String? content;
  final String? image;
  final int? msgType;
  final Function()? onTap;

  const GoodsMsgContainer({
    Key? key,
    this.color,
    this.content,
    this.image,
    this.msgType,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 174.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(20.w),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 118.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16.w),
              ),
            ),
            child: Center(
              child: AppImage(
                width: 76.w,
                height: 76.w,
                radius: 12.w,
                color: Colors.white,
                url: image,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Text(
              content ?? '',
              style: const TextStyle(
                color: Color(0xff8d3737),
              ),
            ),
          ),
          if (msgType != 4)
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 8.w),
              height: 32.w,
              child: AppButton(
                text: '查看禮物',
                onPressed: onTap,
              ),
            ),
        ],
      ),
    );
  }
}
