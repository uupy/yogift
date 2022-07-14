import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchPage extends StatelessWidget implements TabBarPage {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (c) {
        return const Center(
          child: Text('search'),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
        // title: const Text('我的'),
        );
  }
}
