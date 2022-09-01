import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

import 'buy1free1_controller.dart';
import 'widgets/gift_list.dart';

class P2Buy1Free1Page extends StatefulWidget {
  const P2Buy1Free1Page({Key? key}) : super(key: key);

  @override
  _P2Buy1Free1PageState createState() => _P2Buy1Free1PageState();
}

class _P2Buy1Free1PageState extends State<P2Buy1Free1Page> {
  final controller = Get.put(P2Buy1Free1Controller());
  final scrollController = ScrollController();
  final dirPath = Env.config.resourceDirPath;
  late final baseUrl =
      'https://m.yogift.cn/resource$dirPath/p2/static/img/buy-1-free-1';

  @override
  void initState() {
    controller.queryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YO! GIFT 即時送禮平台'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: GetBuilder<P2Buy1Free1Controller>(
          builder: (c) {
            return Column(
              children: [
                buildImg('1'),
                buildImg('2'),
                buildImg('3'),
                GiftList(baseUrl: baseUrl),
                buildImg('4', () {
                  Get.back();
                }),
                for (int i = 5; i <= 11; i++) buildImg('$i'),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildImg(String name, [Function()? onTap]) {
    return AppImage(
      width: double.maxFinite,
      fit: BoxFit.fitWidth,
      withOutDecoration: true,
      url: '$baseUrl/$name.jpg',
      onTap: onTap,
    );
  }
}
