import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/carousel_pagination.dart';
import 'package:yo_gift/widgets/skeleton.dart';

class HomeBanners extends StatelessWidget {
  final bool loading;
  final List<BannerVo> items;
  final int currentBannerIndex;
  final Function(int index)? onChanged;

  const HomeBanners({
    Key? key,
    required this.items,
    this.loading = false,
    this.currentBannerIndex = 0,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          buildSlider(),
          CarouselPagination(
            margin: EdgeInsets.only(bottom: 20.h),
            current: currentBannerIndex,
            itemsCount: items.length,
          )
        ],
      ),
    );
  }

  Widget buildSlider() {
    if (loading) {
      return Skeleton(radius: 24.r);
    }
    if (items.isEmpty) {
      return Container(
        height: 138.h,
        decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        child: const Center(
          child: Text(
            '暫無數據',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 138.h,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          onChanged?.call(index);
        },
      ),
      items: items.map((item) {
        return buildItem(
          image: item.bannerImg,
          onTap: () {
            if (item.link?.isNotEmpty ?? false) {
              Get.toNamed(item.link!);
            }
          },
        );
      }).toList(),
    );
  }

  Widget buildItem({String? image, Function()? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AppImage(
        url: image,
        radius: 24.r,
      ),
    );
  }
}
