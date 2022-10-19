import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final carouselController = CarouselController();

  Future offToIndex([String redirect = '']) async {
    await firstEntryApp.set(false);
    Get.offNamed('/index', parameters: {'redirect': redirect});
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        autoPlay: false,
        height: Get.height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {},
      ),
      items: [
        Stack(
          children: [
            AppAssetImage(
              width: Get.width,
              height: Get.height,
              img: 'intro_01.png',
              fit: BoxFit.cover,
            ),
            buildJumpToIndexBtn(),
            buildNextBtn(1),
          ],
        ),
        Stack(
          children: [
            AppAssetImage(
              width: Get.width,
              height: Get.height,
              img: 'intro_02.png',
              fit: BoxFit.cover,
            ),
            buildJumpToIndexBtn(),
            buildNextBtn(2),
          ],
        ),
        Stack(
          children: [
            AppAssetImage(
              width: Get.width,
              height: Get.height,
              img: 'intro_03.png',
              fit: BoxFit.cover,
            ),
            buildNextBtn(3),
            buildActionBtn(
                left: 70.w,
                onTap: () {
                  offToIndex('/register');
                }),
            buildActionBtn(
                right: 75.w,
                onTap: () {
                  offToIndex('/login');
                }),
          ],
        ),
      ],
    );
  }

  Widget buildActionBtn({double? left, double? right, Function()? onTap}) {
    return Positioned(
      bottom: 132.h,
      left: left,
      right: right,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 110.w,
          height: 60.h,
          color: Colors.transparent,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildNextBtn(int index) {
    return Positioned(
      bottom: 50.h,
      left: 70.w,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 235.w,
          height: 60.h,
          color: Colors.transparent,
        ),
        onTap: () {
          if (index == 3) {
            offToIndex();
          } else {
            carouselController.animateToPage(index);
          }
        },
      ),
    );
  }

  Widget buildJumpToIndexBtn() {
    return Positioned(
      top: 15,
      right: 15,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 50.w,
          height: 50.w,
          color: Colors.transparent,
        ),
        onTap: () {
          offToIndex();
        },
      ),
    );
  }
}
