import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_row.dart';

class UserScoreCard extends StatelessWidget {
  const UserScoreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: double.maxFinite,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: 20.w, bottom: 10.w),
      blurRadius: 4.r,
      child: Stack(
        children: [
          Positioned(
            right: -16.w,
            bottom: -30.w,
            height: 110.w,
            width: 110.w,
            child: const AppAssetImage(
              img: 'img_star.png',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    AppAssetImage(
                      width: 20.w,
                      margin: EdgeInsets.only(right: 4.w),
                      img: 'icon_star_small.png',
                    ),
                    Text(
                      '回贈',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                AppRow(
                  margin: EdgeInsets.only(top: 10.h),
                  mainAxisAlignment: MainAxisAlignment.center,
                  color: Colors.transparent,
                  body: Text(
                    '- -',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  suffix: [
                    Text(
                      '去兌換',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ),
                    AppAssetImage(
                      width: 9.w,
                      margin: EdgeInsets.only(left: 4.w),
                      img: 'icon_arrow_right.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
