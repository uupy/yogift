import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:uni_links/uni_links.dart';
import 'package:yo_gift/common/app_theme_data.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/router/router.dart';

import 'common/app.dart';
import 'common/app_controller.dart';
import 'common/app_storage.dart';

void main() async {
  /// 设置沉浸式状态栏（需要在runApp前）
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
  StreamSubscription? _sub;
  String redirectPath = '';

  @override
  void initState() {
    subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initUniLinks();
    super.initState();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    app.hasNetWork = networkResults.contains(result);
  }

  String getJumpPath(String? link) {
    String result = '';
    if (link?.isNotEmpty ?? false) {
      final _jumpPath = link!.replaceFirst('dynamictheme://yogift.hk', '');
      final toPath = _jumpPath.split('?')[0];
      final currentPath = Get.currentRoute.split('?')[0];

      if (!['/', '/index', '/pages/main/index/index'].contains(_jumpPath) &&
          toPath != currentPath) {
        logger.i('path: $_jumpPath');
        logger.i('current: ${Get.currentRoute}');
        result = _jumpPath;
      }
    }
    return result;
  }

  Future<void> initUniLinks() async {
    String? initialLink;
    // App未打开的状态在这个地方捕获scheme
    try {
      initialLink = await getInitialLink();
      setState(() {
        redirectPath = getJumpPath(initialLink);
      });
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
    // App打开的状态监听scheme
    // Attach a listener to the stream
    _sub = linkStream.listen((String? link) {
      // Parse the link and warn the user, if it is not correct
      final _jumpPath = getJumpPath(link);
      if (_jumpPath.isNotEmpty) {
        Get.toNamed(_jumpPath);
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      logger.e(err.toString());
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      child: GetMaterialApp(
        /// 主题设置
        theme: appThemeData,
        home: MaterialHome(redirectPath: redirectPath),
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
  final String? redirectPath;
  const MaterialHome({Key? key, this.redirectPath}) : super(key: key);

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
        final firstEnter = await firstEntryApp.get() ?? true;
        if (firstEnter) {
          Get.offNamed('/guide');
        } else {
          final redirect = widget.redirectPath ?? '';
          app.updateAuthData();
          Get.offNamed('/index?redirect=$redirect');
        }
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
