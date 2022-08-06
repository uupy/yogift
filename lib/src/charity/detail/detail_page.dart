import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'detail_controller.dart';
import 'widgets/base_info.dart';
import 'widgets/favorites_list.dart';

class CharityDetailPage extends StatefulWidget {
  const CharityDetailPage({Key? key}) : super(key: key);

  @override
  _CharityDetailPageState createState() => _CharityDetailPageState();
}

class _CharityDetailPageState extends State<CharityDetailPage> {
  final controller = Get.put(CharityDetailController());

  @override
  void initState() {
    controller.fetchData();
    controller.queryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('慈善捐贈'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppAssetImage(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: 20.w),
              img: 'banner3.png',
            ),
            const BaseInfo(),
            const FavoritesList(),
          ],
        ),
      ),
    );
  }
}
