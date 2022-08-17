import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class GiftMethodSelectView extends StatelessWidget {
  final bool isBuy1Get1Free;
  final Function(int type)? onTap;

  const GiftMethodSelectView({
    Key? key,
    this.isBuy1Get1Free = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.w),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isBuy1Get1Free)
            buildItem(
              onTap: () {
                onTap?.call(1);
              },
              color: const Color(0xff7dc878),
              children: [
                buildContent(
                  title: '送給自己',
                  desc: '犒勞一下辛苦的自己',
                  titleColor: const Color.fromRGBO(255, 255, 255, 0.9),
                  descColor: const Color.fromRGBO(255, 255, 255, 0.5),
                ),
                Positioned(
                  right: -4.w,
                  bottom: -2.w,
                  child: AppAssetImage(
                    width: 60.w,
                    img: 'img_color_bar.png',
                  ),
                ),
              ],
            ),
          if (!isBuy1Get1Free) SizedBox(width: 12.w),
          buildItem(
            onTap: () {
              onTap?.call(2);
            },
            color: const Color(0xffffe100),
            children: [
              buildContent(
                title: '送給好友',
                desc: '贈人玫瑰，手有餘香',
                titleColor: const Color.fromRGBO(0, 0, 0, 0.9),
                descColor: const Color.fromRGBO(0, 0, 0, 0.26),
              ),
              Positioned(
                right: -20.w,
                bottom: -8.w,
                child: AppAssetImage(
                  width: 100.w,
                  img: 'img_love.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContent({
    String? title,
    String? desc,
    Color? titleColor,
    Color? descColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: titleColor,
            ),
          ),
          Text(
            desc ?? '',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: descColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    Color? color,
    List<Widget> children = const [],
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 162.w,
        height: 90.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}
