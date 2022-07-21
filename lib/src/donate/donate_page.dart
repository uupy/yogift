import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

class DonatePage extends StatelessWidget implements TabBarPage {
  const DonatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          AppAssetImage(
            width: double.maxFinite,
            margin: EdgeInsets.all(20.w),
            img: 'banner3.png',
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('慈善捐贈'),
    );
  }
}
