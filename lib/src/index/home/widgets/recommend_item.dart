import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_tag.dart';
import 'package:yo_gift/widgets/goods/goods_sending_tag.dart';

class RecommendItem extends StatelessWidget {
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
  final String? tag;
  final String? guid;

  const RecommendItem({
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
    this.tag,
    this.guid,
  }) : super(key: key);

  void handleAction([Map<String, String>? params]) {
    final parameters = params ?? {};
    if (guid != null) {
      parameters['id'] = guid!;
      Get.toNamed('/pages/goods/detail/index', parameters: parameters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleAction();
      },
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 8.r,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImgContainer(),
                SizedBox(width: 10.w),
                Expanded(
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
                        child: Text(
                          desc ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, .4),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      AppTag(text: '#${tag ?? ''}'),
                      SizedBox(height: 10.w),
                      Row(
                        children: [
                          Text(
                            '\$$buyPrice',
                            style: TextStyle(
                              fontSize: 20.sp,
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
              ],
            ),
            SizedBox(height: 15.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildFooterItem(
                  text: '拜託',
                  icon: 'icon_please.png',
                  background: const Color(0xfffffdeb),
                  onTap: () {
                    handleAction({'buyType': '3'});
                  },
                ),
                buildFooterItem(
                  text: '贈送',
                  icon: 'icon_mine_gift.png',
                  onTap: () {
                    handleAction({'buyType': '2'});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImgContainer() {
    return Stack(
      children: [
        AppImage(
          width: 100.w,
          height: 100.w,
          url: coverImg,
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
    );
  }

  Widget buildFooterItem({
    String? text,
    String? icon,
    Color? background,
    Function()? onTap,
  }) {
    return Container(
      width: 96.w,
      height: 32.w,
      margin: EdgeInsets.only(left: 10.w),
      child: AppButton(
        onPressed: onTap,
        backgroundColor: background,
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
