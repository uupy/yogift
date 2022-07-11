import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/common/oss/oss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'index_controller.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexView createState() => _IndexView();
}

class _IndexView extends State<IndexPage> {
  final _controller = Get.put(IndexController());

  @override
  void initState() {
    initPage();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  Future initPage() async {
    app.init(context);
    await oss.init();
    await oss.start();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexController>(
      builder: (c) {
        final route = c.currentRoute;
        return Scaffold(
          key: _controller.scaffoldKey,
          appBar: route?.page?.appBar,
          body: c.pages.length == 1
              ? c.pages.first
              : PageView(
                  controller: c.pageController,
                  children: c.pages,
                  physics: const NeverScrollableScrollPhysics(),
                ),
          bottomNavigationBar: c.navBarItems.length < 2
              ? null
              : BottomNavigationBar(
                  backgroundColor: const Color.fromRGBO(249, 249, 249, 0.94),
                  selectedItemColor: AppTheme.primaryColor,
                  unselectedItemColor: const Color(0xffA6A39E),
                  currentIndex: c.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (index) {
                    c.switchTabBar(index);
                  },
                  items: c.navBarItems,
                ),
        );
      },
    );
  }
}
