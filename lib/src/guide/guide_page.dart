import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/carousel_pagination.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final carouselController = CarouselController();
  int currentIndex = 0;

  Future offToIndex([String redirect = '']) async {
    await firstEntryApp.set(false);
    Get.offNamed('/index', parameters: {'redirect': redirect});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            autoPlay: false,
            height: Get.height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: [
            Stack(
              children: [
                AppAssetImage(
                  width: Get.width,
                  height: Get.height,
                  img: 'bg_guide1.png',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: AppAssetImage(
                    img: 'img_guide1.png',
                    width: 300.w,
                    noWrapper: true,
                  ),
                ),
                buildJumpToIndexBtn(const Color(0xff905D72)),
                buildNextBtn(1),
              ],
            ),
            Stack(
              children: [
                AppAssetImage(
                  width: Get.width,
                  height: Get.height,
                  img: 'bg_guide2.png',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: AppAssetImage(
                    img: 'img_guide2.png',
                    width: 300.w,
                    noWrapper: true,
                  ),
                ),
                buildJumpToIndexBtn(const Color(0xffA04A42)),
                buildNextBtn(2, color: const Color(0xffA04A42)),
              ],
            ),
            Stack(
              children: [
                Stack(
                  children: [
                    AppAssetImage(
                      width: Get.width,
                      height: Get.height,
                      img: 'bg_guide3.png',
                      fit: BoxFit.fill,
                    ),
                    Center(
                      child: AppAssetImage(
                        img: 'img_guide3.png',
                        width: 300.w,
                        noWrapper: true,
                      ),
                    ),
                    buildJumpToIndexBtn(const Color(0xff5070A4)),
                    buildNextBtn(
                      3,
                      text: '開始',
                      color: const Color(0xff5070A4),
                    ),
                    buildActionBtn(
                      onTap: () {
                        offToIndex('/p2/guide/index');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CarouselPagination(
            margin: EdgeInsets.only(bottom: 20.w),
            current: currentIndex,
            itemsCount: 3,
            borderWidth: 1.5,
            space: 15.w,
            activeColor: const Color(0xffECDAD8),
            color: Colors.transparent,
            borderColor: const Color(0xffF1E1DD),
          ),
        ),
      ],
    );
  }

  Widget buildActionBtn({Function()? onTap}) {
    return Positioned(
      bottom: 105.w,
      left: (Get.width - 210.w) / 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 210.w,
          height: 42.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
          ),
          child: Center(
            child: Text(
              '如何即時送禮？',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildNextBtn(int index, {String? text, Color? color}) {
    return Positioned(
      bottom: 45.w,
      left: (Get.width - 210.w) / 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 210.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          child: Center(
            child: Text(
              text ?? '繼續',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: color ?? const Color(0xffB2889D),
                letterSpacing: 1.2,
              ),
            ),
          ),
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

  Widget buildJumpToIndexBtn([Color? color]) {
    return Positioned(
      top: 15,
      right: 15,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 50.w,
          height: 50.w,
          color: Colors.transparent,
          child: Center(
            child: Text(
              '跳過',
              style: TextStyle(
                fontSize: 14.sp,
                color: color,
              ),
            ),
          ),
        ),
        onTap: () {
          offToIndex();
        },
      ),
    );
  }
}
