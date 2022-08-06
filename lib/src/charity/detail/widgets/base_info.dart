import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/charity/detail/detail_controller.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class BaseInfo extends StatelessWidget {
  const BaseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CharityDetailController>(
      id: 'BaseInfo',
      builder: (c) {
        return Stack(
          children: [
            AppImage(
              height: 154.w,
              url: c.detail?.charityBImg,
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 130.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.w),
                  Text(
                    '「${c.detail?.charityName}」的願望清單',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  AppSimpleRow(
                    margin: EdgeInsets.only(top: 12.w, bottom: 16.w),
                    expanded: Text(
                      '最近更新：${c.detail?.lastUpdateTime}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ),
                    suffix: Text(
                      '慈善團體編號：${c.detail?.charityNo}',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                    maxLines: c.expendDetail ? null : 3,
                    child: Text(
                      c.detail?.cDetail ?? '',
                      overflow: c.expendDetail ? null : TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  if (!c.expendDetail)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          c.expendDetail = true;
                          c.update(['BaseInfo']);
                        },
                        child: Text(
                          '更多',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff007aff),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
