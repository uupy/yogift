import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class HeaderHasLogged extends StatelessWidget {
  final String? avatar;
  final String? phone;
  final String? birthday;

  const HeaderHasLogged({
    Key? key,
    this.avatar,
    this.phone,
    this.birthday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 86.r,
          height: 86.r,
          margin: EdgeInsets.only(right: 20.w),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(86.r),
            ),
          ),
          child: AppImage(url: avatar),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBoldText(phone ?? ''),
              Text(
                birthday ?? '',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 0.26),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              AppAssetImage(
                width: 24.w,
                img: 'icon_wishlist.png',
              ),
              Text(
                '願望清單',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildBoldText(String text, [bool underline = false]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xff414042),
        decoration: underline ? TextDecoration.underline : null,
      ),
    );
  }
}
