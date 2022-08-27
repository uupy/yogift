import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import 'favorite_button.dart';
import 'goods_sending_tag.dart';
import 'goods_top_tag.dart';

class GoodsItem extends StatefulWidget {
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
  final String? guid;
  final Function()? onTap;
  final Function(int value)? onFavoriteChanged;

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
    this.guid,
    this.onTap,
    this.onFavoriteChanged,
  }) : super(key: key);

  @override
  _GoodsItemState createState() => _GoodsItemState();
}

class _GoodsItemState extends State<GoodsItem> {
  void handleAction([Map<String, String>? params]) {
    final parameters = params ?? {};
    if (widget.guid != null) {
      parameters['id'] = widget.guid!;
      Get.toNamed('/pages/goods/detail/index', parameters: parameters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buy1Get1Free = widget.buy1Get1Free;
    final originalPrice = widget.originalPrice;
    final price = widget.buyPrice ?? 0;

    return GestureDetector(
      onTap: () {
        handleAction({'buyType': ''});
      },
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
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
                        widget.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.w, bottom: 10.w),
                      child: Text(
                        widget.desc ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, .4),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    buildImgContainer(widget.topIndex),
                    SizedBox(height: 8.w),
                    Row(
                      children: [
                        Text(
                          '\$${Decimal.parse(price.toString())}',
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
                  iconImg: 'icon_mine_gift.png',
                  onTap: () {
                    handleAction({'buyType': '2'});
                  },
                ),
                buildFooterItem(
                  text: '拜託好友',
                  iconImg: 'icon_please.png',
                  onTap: () {
                    handleAction({'buyType': '3'});
                  },
                ),
                buildFooterItem(
                  custom: FavoriteButton(
                    guid: widget.guid,
                    favorite: widget.favorite,
                    onChanged: widget.onFavoriteChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImgContainer(int? index) {
    return Expanded(
      child: Stack(
        children: [
          AppImage(
            url: widget.coverImg,
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
              method: widget.sendingMethod ?? 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooterItem({
    String? text,
    String? iconImg,
    Widget? custom,
    Function()? onTap,
  }) {
    final child = Padding(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: custom ??
          Column(
            children: [
              AppAssetImage(
                img: iconImg,
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
    );

    if (onTap == null) {
      return Expanded(child: child);
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: child,
      ),
    );
  }
}
