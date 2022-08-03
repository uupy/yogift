import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/router/tab_bar.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'widgets/charity_group.dart';

class CharityPage extends StatelessWidget implements TabBarPage {
  const CharityPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('慈善捐贈'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAssetImage(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(vertical: 20.w),
            img: 'banner3.png',
          ),
          const CharityListGroup(),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
