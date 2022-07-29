import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:yo_gift/widgets/header_background.dart';
import 'package:yo_gift/widgets/module_title.dart';

import 'all_brands_controller.dart';

class AllBrandsPage extends StatefulWidget {
  const AllBrandsPage({Key? key}) : super(key: key);

  @override
  _AllBrandsPageState createState() => _AllBrandsPageState();
}

class _AllBrandsPageState extends State<AllBrandsPage> {
  final controller = Get.put(AllBrandsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('所有品牌'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            const HeaderBackground(),
            const ModuleTitle(
              textEn: 'ALL BRANDS',
              textCn: '所有品牌',
              textEnColor: Color.fromRGBO(255, 255, 255, 0.4),
            ),
            GetBuilder<AllBrandsController>(
              builder: (c) {
                return Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 70.w, left: 15.w),
                  child: Wrap(
                    children: c.list.map((item) {
                      return AppCard(
                        width: 105.w,
                        height: 105.w,
                        margin: EdgeInsets.all(5.w),
                        padding: EdgeInsets.zero,
                        child: AppImage(
                          url: item.bussinessImg,
                          radius: 20.r,
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
