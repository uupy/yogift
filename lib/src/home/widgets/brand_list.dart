import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/home/home_controller.dart';
import 'package:yo_gift/widgets/AssetImgIcon.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/app_radio.dart';
import 'package:yo_gift/widgets/module_title.dart';

class HomeBrandList extends StatelessWidget {
  const HomeBrandList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'brandWrapper',
      builder: (c) {
        if (c.brandCategories.isEmpty) {
          return Container();
        }
        return Column(
          children: [
            const ModuleTitle(
              textCn: '瀏覽品牌',
              textEn: 'BROWSE BRANDS',
              suffixAssetImg: 'icon_label_2.png',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: AppRadioGroup(
                onChanged: (value, index) {
                  c.onCategoryChanged(index);
                },
                value: c.currentCategoryId,
                items: c.brandCategories.map((e) {
                  return AppRadio(
                    label: e.className,
                    value: e.id,
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 100.w,
              margin: EdgeInsets.only(top: 15.h, bottom: 30.h),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: c.currentBrandList.length,
                itemBuilder: (context, index) {
                  final item = c.currentBrandList[index];
                  return AppImage(
                    width: 100.w,
                    height: 100.w,
                    url: item.bussinessImg,
                    radius: 20.r,
                    border: Border.all(
                      width: 0.5,
                      color: const Color(0xffe6e6e6),
                    ),
                    margin: index == 0
                        ? EdgeInsets.fromLTRB(20.w, 0, 6.w, 0)
                        : (index == c.currentBrandList.length - 1
                            ? EdgeInsets.fromLTRB(6.w, 0, 20.w, 0)
                            : EdgeInsets.symmetric(horizontal: 6.w)),
                  );
                },
              ),
            ),
            Container(
              width: 120.w,
              margin: EdgeInsets.only(bottom: 15.h),
              child: AppButton(
                backgroundColor: const Color(0xfffffdeb),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '全部品牌',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.9),
                      ),
                    ),
                    AssetImgIcon(
                      width: 10.w,
                      margin: EdgeInsets.only(left: 4.w),
                      img: 'icon_arrow_right2.png',
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
