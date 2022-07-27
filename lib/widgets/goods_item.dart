import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/services/user_favorites.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

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
  }) : super(key: key);

  @override
  _GoodsItemState createState() => _GoodsItemState();
}

class _GoodsItemState extends State<GoodsItem> {
  int _favorite = 0;

  @override
  void initState() {
    setState(() {
      _favorite = widget.favorite ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buy1Get1Free = widget.buy1Get1Free;
    final originalPrice = widget.originalPrice;

    return GestureDetector(
      onTap: () {
        logger.i('view');
        Get.toNamed('/goods/detail', arguments: widget.guid);
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
                          '\$${widget.buyPrice}',
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
                  onTap: () {},
                ),
                buildFooterItem(
                  text: '拜託好友',
                  icon: 'icon_please.png',
                  onTap: () {},
                ),
                buildFooterItem(
                  text: '願望清單',
                  icon: 'icon_heart_$_favorite.png',
                  onTap: () async {
                    logger.i('願望清單');
                    if (widget.guid != null) {
                      await UserFavoritesService.addOrDelete(widget.guid!);
                      setState(() {
                        _favorite = _favorite == 0 ? 1 : 0;
                      });
                    }
                  },
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
