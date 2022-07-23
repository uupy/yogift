import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import 'goods_sending_tag.dart';
import 'goods_top_tag.dart';

class GoodsItem extends StatelessWidget {
  final double? width;
  final double? height;
  final double? buyPrice;
  final String? originalPrice;
  final String? name;
  final String? desc;
  final String? coverImg;
  final int? favorite;
  final int? sendingMethod;
  final int? buy1Get1Free;
  final EdgeInsetsGeometry? margin;
  final int? topIndex;

  const GoodsItem({
    Key? key,
    this.width,
    this.height,
    this.buyPrice,
    this.originalPrice,
    this.name,
    this.desc,
    this.coverImg,
    this.favorite,
    this.sendingMethod,
    this.buy1Get1Free,
    this.margin,
    this.topIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xfffffdeb),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.w,
                    child: Text(
                      name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.w, bottom: 10.w),
                    child: Text(
                      desc ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, .4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                  buildImgContainer(topIndex),
                  SizedBox(height: 8.w),
                  Row(
                    children: [
                      Text(
                        '\$$buyPrice',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (buy1Get1Free == 1)
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '買一送一',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xffff3b30),
                            ),
                          ),
                        ),
                      if (buy1Get1Free == 0 &&
                          (originalPrice?.isNotEmpty ?? false))
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            '\$$originalPrice',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.26),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              buildFooterItem(
                text: '贈送好友',
                icon: 'icon_mine_gift.png',
              ),
              buildFooterItem(
                text: '拜託好友',
                icon: 'icon_please.png',
              ),
              buildFooterItem(
                text: '願望清單',
                icon: 'icon_heart_0.png',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImgContainer(int? index) {
    return Expanded(
      child: Stack(
        children: [
          AppImage(
            url: coverImg,
            color: Colors.white,
            radius: 12.r,
          ),
          if (index != null)
            Positioned(
              top: 0,
              left: 10.w,
              child: GoodsTopTag(
                index: index,
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

  Widget buildFooterItem({String? text, String? icon, Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: Column(
            children: [
              AppAssetImage(
                img: icon,
                width: 20.w,
              ),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
