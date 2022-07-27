import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/carousel_pagination.dart';
import 'package:yo_gift/widgets/skeleton.dart';

class GoodsDetailImages extends StatelessWidget {
  const GoodsDetailImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailController>(
      id: 'GoodsDetailImages',
      builder: (c) {
        final images = [];

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.w),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              buildSlider(
                loading: c.loading,
                items: images,
                onChanged: (index) {
                  c.onImageChanged(index);
                },
              ),
              CarouselPagination(
                margin: EdgeInsets.only(bottom: 20.w),
                current: c.currentImageIndex,
                itemsCount: images.length,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildSlider({
    bool loading = false,
    List items = const [],
    Function(int index)? onChanged,
  }) {
    if (loading) {
      return Skeleton(radius: 24.r, height: 310.w);
    }
    if (items.isEmpty) {
      return Container(
        height: 310.w,
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
        height: 310.w,
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
