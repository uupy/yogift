import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/common/oss/oss.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/AssetImgIcon.dart';

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
              : Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('lib/assets/images/bg_navbar.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black.withOpacity(0.6),
                    currentIndex: c.currentIndex,
                    type: BottomNavigationBarType.fixed,
                    onTap: (index) {
                      c.switchTabBar(index);
                    },
                    items: c.navBarItems,
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppTheme.primaryColor,
            child: Center(
              child: AssetImgIcon(
                width: 24.w,
                img: 'icon_gift.png',
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
