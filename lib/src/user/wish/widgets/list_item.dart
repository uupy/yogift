import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/user_favorites.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';
import 'package:yo_gift/widgets/goods/favorite_button.dart';

class WishListItem extends StatelessWidget {
  final UserFavoritesItemVo item;
  final bool isFriend;
  final Function()? onRemoved;
  const WishListItem({
    Key? key,
    required this.item,
    this.isFriend = false,
    this.onRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOk = item.giftOk == '1';
    final buyPrice = item.buyPrice;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImgContainer(item.cCoverImg, item.sendingMethod, !isOk),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSimpleRow(
                    color: Colors.transparent,
                    expanded: Text(
                      item.giftName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    suffix: !isFriend
                        ? FavoriteButton(
                            guid: item.gGuid,
                            favorite: 1,
                            showText: false,
                            disabled: !isOk,
                            onChanged: (value) {
                              onRemoved?.call();
                            },
                          )
                        : null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
                    child: Text(
                      item.bussinessName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, .4),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    '\$${Decimal.parse(buyPrice.toString())}',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!isFriend)
              buildFooterItem(
                text: '拜託',
                icon: 'icon_please.png',
                background: const Color(0xfffffdeb),
                disabledBackground: Colors.white,
                disabled: !isOk,
                onTap: () {
                  Get.toNamed('/pages/goods/detail/index', parameters: {
                    'id': item.gGuid!,
                    'buyType': '3',
                  });
                },
              ),
            buildFooterItem(
              text: '購買',
              icon: 'icon_shopping_bag.png',
              disabled: !isOk,
              onTap: () {
                Get.toNamed('/pages/goods/detail/index', parameters: {
                  'id': item.gGuid!,
                  'buyType': isFriend ? '2' : '1',
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildImgContainer(
    String? url,
    int? sendingMethod,
    bool disabled,
  ) {
    return Stack(
      children: [
        AppImage(
          width: 90.w,
          height: 90.w,
          url: url,
          color: Colors.white,
          colorBlendMode: disabled ? BlendMode.color : null,
          radius: 12.r,
          border: Border.all(
            width: 0.5,
            color: const Color(0xffe6e6e6),
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   child: GoodsSendingTag(
        //     method: sendingMethod ?? 1,
        //   ),
        // ),
      ],
    );
  }

  Widget buildFooterItem({
    String? text,
    String? icon,
    Color? background,
    Color? disabledBackground,
    bool disabled = false,
    Function()? onTap,
  }) {
    return Container(
      width: 96.w,
      height: 32.w,
      margin: EdgeInsets.only(left: 10.w),
      child: AppButton(
        onPressed: onTap,
        backgroundColor: background,
        disabledBackgroundColor: disabledBackground,
        disabled: disabled,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssetImage(
              img: icon,
              width: 16.w,
              margin: EdgeInsets.only(right: 5.w),
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
    );
  }
}
