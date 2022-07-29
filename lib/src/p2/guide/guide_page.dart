import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/p2/guide/guide_controller.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class P2GuidePage extends StatefulWidget {
  const P2GuidePage({Key? key}) : super(key: key);

  @override
  _P2GuidePageState createState() => _P2GuidePageState();
}

class _P2GuidePageState extends State<P2GuidePage> {
  final controller = Get.put(P2GuideController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('了解更多好處'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(46.w),
          child: GetBuilder<P2GuideController>(
            builder: (c) {
              final type = c.type;

              return AppSimpleRow(
                height: 46.w,
                color: Colors.white,
                children: [
                  AppAssetImage(
                    width: 144.w,
                    img: 'guide/btn_how_to_${type == 0 ? 1 : 0}.png',
                    onTap: () {
                      c.type = 0;
                      c.update();
                    },
                  ),
                  AppAssetImage(
                    width: 90.w,
                    img: 'guide/title.png',
                  ),
                  AppAssetImage(
                    width: 66.w,
                    img: 'guide/btn_send_${type == 1 ? 1 : 0}.png',
                    onTap: () {
                      c.type = 1;
                      c.update();
                    },
                  ),
                  AppAssetImage(
                    width: 66.w,
                    img: 'guide/btn_take_self_${type == 2 ? 1 : 0}.png',
                    onTap: () {
                      c.type = 2;
                      c.update();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: GetBuilder<P2GuideController>(
          builder: (c) {
            return Column(
              children: [
                AppAssetImage(
                  img: 'guide/${c.type}_1.png',
                ),
                AppAssetImage(
                  img: 'guide/${c.type}_2.png',
                ),
                AppAssetImage(
                  img: 'guide/${c.type}_3.png',
                ),
                AppAssetImage(
                  img: 'guide/${c.type}_4.png',
                ),
                if (c.type != 2)
                  AppAssetImage(
                    img: 'guide/${c.type}_5.png',
                  ),
                AppAssetImage(
                  img: 'guide/back.png',
                  onTap: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.ease,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
