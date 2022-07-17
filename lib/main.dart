import 'dart:async';

import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/common/app_theme_data.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/router/router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/app.dart';
import 'common/app_controller.dart';

void main() async {
  /// 设置沉浸式状态栏（需要在runApp前）
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  runApp(
    ScreenUtilInit(
      // designSize: const Size(750, 1334),
      designSize: const Size(375, 667),
      builder: (context, widget) => const RootApp(),
    ),
  );
}

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootApp createState() => _RootApp();
}

class _RootApp extends State<RootApp> {
  late StreamSubscription<ConnectivityResult> subscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    final networks = [ConnectivityResult.mobile, ConnectivityResult.wifi];
    app.hasNetWork = networks.contains(result);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      child: GetMaterialApp(
        /// 主题设置
        theme: appThemeData,
        home: const MaterialHome(),
        builder: EasyLoading.init(
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        ),
        initialRoute: appRouter.initialRoute,
        getPages: appRouter.getPages,
        unknownRoute: appRouter.getPages[0],
        debugShowCheckedModeBanner: !Env.isProd,
      ),
    );
  }
}

class MaterialHome extends StatefulWidget {
  const MaterialHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MaterialHome();
  }
}

class _MaterialHome extends State<MaterialHome> {
  final appController = Get.put(AppController());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    appController.init(
      onComplete: (data) async {
        String _token = await authToken.get() ?? '';
        if (_token.isNotEmpty) {
          Get.offNamed('index');
        } else {
          Get.offNamed('login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 120.w,
          margin: EdgeInsets.only(bottom: 90.h),
          child: const Image(
            image: AssetImage('lib/assets/images/logo.png'),
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
