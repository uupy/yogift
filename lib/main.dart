import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:yo_gift/common/app_theme_data.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/router/router.dart';

import 'common/app.dart';
import 'common/app_controller.dart';

void main() async {
  /// 设置沉浸式状态栏（需要在runApp前）test
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ScreenUtilInit(
      // designSize: const Size(750, 1334),
      designSize: const Size(375, 667),
      builder: (context, widget) => const RootApp(),
    ),
  );
}

final networkResults = [ConnectivityResult.mobile, ConnectivityResult.wifi];

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
    app.hasNetWork = networkResults.contains(result);
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
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        }),
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
    final result = await (Connectivity().checkConnectivity());
    app.hasNetWork = networkResults.contains(result);
    await app.init(context);
    appController.init(
      onComplete: (data) async {
        app.updateAuthData();
        Get.offNamed('index');
      },
      onError: (e) {
        logger.e(e);
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
