import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import '../buy1free1_controller.dart';

class GiftList extends StatelessWidget {
  final String baseUrl;

  const GiftList({Key? key, required this.baseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<P2Buy1Free1Controller>(
      id: 'GiftList',
      builder: (c) {
        return Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 10.w),
          color: const Color(0xfffffcee),
          child: Wrap(
            children: c.list.map((item) {
              return AppCard(
                onTap: () {
                  Get.toNamed('/pages/goods/detail/index?id=${item.gGuid}');
                },
                width: 110.w,
                height: 110.w,
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    AppImage(
                      width: 110.w,
                      height: 110.w,
                      url: item.cCoverImg,
                      radius: 15.r,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: AppImage(
                        width: 55.w,
                        withOutDecoration: true,
                        color: Colors.transparent,
                        fit: BoxFit.fitWidth,
                        url: '$baseUrl/icon_band.png',
                      ),
                    ),
                    Positioned(
                      bottom: 5.w,
                      left: 5.w,
                      right: 5.w,
                      height: 20.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xfffffcee),
                          borderRadius: BorderRadius.all(Radius.circular(10.w)),
                        ),
                        child: Text(
                          item.giftName ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff414042),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
