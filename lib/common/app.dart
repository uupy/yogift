import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/share/share_card.dart';

import 'app_storage.dart';
import 'custom_dialog/custom_dialog.dart';
import 'dart:ui' as ui;

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class App {
  App._internal();

  static App? _instance;

  factory App.getInstance() => _instance ??= App._internal();

  static FToast? fToast;

  /// 是否有网络
  bool hasNetWork = true;
  String deviceModel = '';
  AuthDataVo? authData;
  UserInfoVo? userInfo;
  Function()? loginCallback;

  /// 初始化
  Future init(BuildContext context) async {
    fToast ??= FToast();
    fToast?.init(context);
    await getDeviceModel();
  }

  /// 获取设备型号
  Future getDeviceModel() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final adi = await deviceInfo.androidInfo;
      deviceModel = adi.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceModel = iosInfo.utsname.machine;
    }
  }

  /// showToast
  void showToast(String msg) {
    if (msg.isNotEmpty) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: msg,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.75),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void toastCustom(Widget child) {
    fToast?.removeCustomToast();
    fToast?.showToast(
      child: child,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.CENTER,
    );
  }

  void toast(String msg, {Icon? icon, IconData? iconData}) {
    toastCustom(
      Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.75),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  icon ??
                      Icon(
                        iconData,
                        color: Colors.white,
                        size: 60,
                      ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      msg,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toastSuccess(String msg) {
    toast(msg, iconData: IconFont.icon_success);
  }

  void toastError(String msg) {
    toast(msg, iconData: IconFont.icon_fail);
  }

  /// 确认弹窗
  Future<bool?> confirm({
    String? title,
    String? contentText,
    String? cancelText,
    String? confirmText,
    Widget? content,
    double? height,
    List<Widget>? actions,
    bool? barrierDismissible,
    BuildContext? context,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) async {
    return await showAnimationDialog<bool>(
      context: context ?? Get.context!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height ?? 182.w,
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.w),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.w,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15.w,
                        right: 20.w,
                        child: AppAssetImage(
                          width: 16.w,
                          img: 'icon_close.png',
                          onTap: () {
                            Get.back(result: false);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: content ??
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Center(
                          child: Text(
                            contentText ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 28.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: actions ??
                        [
                          Expanded(
                            child: AppButton(
                              text: cancelText ?? '取消',
                              backgroundColor: const Color(0xfffffdeb),
                              onPressed: () {
                                Get.back(result: false);
                                onCancel?.call();
                              },
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: AppButton(
                              text: confirmText ?? '確定',
                              shadow: true,
                              onPressed: () {
                                Get.back(result: true);
                                onConfirm?.call();
                              },
                            ),
                          ),
                        ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 保存图片到本地
  void saveImage(key) {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    boundary
        .toImage(pixelRatio: ui.window.devicePixelRatio)
        .then((value) async {
      ByteData? byteData =
          await value.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      Permission filePermission =
          Platform.isIOS ? Permission.photos : Permission.storage;
      var status = await Permission.photos.status;

      if (!status.isGranted) {
        Map<Permission, PermissionStatus> statuses =
            await [filePermission].request();
        app.saveImage(key);
      }
      if (status.isGranted) {
        final result =
            await ImageGallerySaver.saveImage(pngBytes!, quality: 100);
        logger.i({'result:', result.filePath});
      }
    });
  }

  /// 底部彈出層
  Future showBottomModal<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = true,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: isScrollControlled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      builder: builder,
    );
  }

  /// 分享海报
  Future showSharePoster<T>(
      {required BuildContext context,
      required data,
      required buttonText}) async {
    OverlayEntry entry = OverlayEntry(
      builder: (_) {
        return Offstage(
          offstage: false,
          child: Center(
            child: ShareCard(
              buttonText: buttonText,
              cardImageUrl: data?.cardImageUrl,
              cardMsg: data?.cardMsg,
              goodsImageUrl: data?.imageUrl,
              goodsName: data?.goodsName,
            ),
          ),
        );
      },
    );

    Overlay.of(context)?.insert(entry);

    Timer(const Duration(milliseconds: 1000), () async {
      app.saveImage(shareCardKey);
    });
  }

  /// 退出登录
  Future logout({Function()? success}) async {
    await authDataStorage.remove();
    await accessToken.remove();
    await loginUser.remove();
    await lastOpenAdTime.remove();
    await searchHistory.remove();

    authData = null;
    userInfo = null;

    if (success != null) {
      success.call();
    } else {
      if (Get.currentRoute != '/login') {
        Get.toNamed('/login');
      }
    }
  }

  /// 更新登录用户信息
  Future updateUserInfo() async {
    if (authData?.accessToken?.isNotEmpty ?? false) {
      final res = await UserService.getInfo();
      final resData = res.data ?? {};
      final _data = resData['data'] ?? {};
      await loginUser.set(_data);
      userInfo = UserInfoVo.fromJson(_data);
    } else {
      await loginUser.set(null);
      userInfo = null;
    }
  }

  Future setAuthData(Map<String, dynamic>? data) async {
    await authDataStorage.set(data);
    authData = AuthDataVo.fromJson(data ?? {});
  }

  /// 更新登录信息
  Future updateAuthData([Map<String, dynamic>? data]) async {
    if (data != null) {
      await setAuthData(data);
    } else {
      final _authData = await authDataStorage.get() ?? {};
      authData = AuthDataVo.fromJson(_authData);
      if (authData?.refreshToken?.isNotEmpty ?? false) {
        final res = await UserService.refreshToken(authData!.refreshToken!);
        final resData = res.data ?? {};
        await setAuthData(resData['data'] ?? {});
      }
    }

    await accessToken.set(authData?.accessToken);
  }

  void navToByLinkType({
    int linkType = 0,
    String? link,
    bool isDialog = false,
  }) async {
    final _link = link ?? '';
    final links = _link.split('|');
    String argument = '';
    String wxAppId = '';

    /// userName: "gh_4XXXXXXXXX",//原始id 小程序的 原始id 不是appid
    String wxUsername = '';
    String wxPath = '';

    if (links.isNotEmpty) {
      if (linkType == 3) {
        if (links.length < 4) {
          app.showToast('操作異常，請稍後再試');
          return;
        }
        wxUsername = links[1];
        wxPath = links[2];
        wxAppId = links[3];
      } else {
        argument = links.last;
        if (argument.isNotEmpty && linkType != 4) {
          argument = '/$argument';
        }
      }
    }

    if (isDialog) {
      Get.back();
    }

    await Future.delayed(const Duration(milliseconds: 100));

    if (linkType == 3 && wxUsername.isNotEmpty) {
      await fluwx.registerWxApi(
        // appId: Env.config.wxAppId,
        appId: wxAppId,
        universalLink: Env.config.universalLink,
      );
      final isInstalled = await fluwx.isWeChatInstalled;

      if (isInstalled) {
        fluwx.launchWeChatMiniProgram(
          username: wxUsername,
          // path: wxPath,
        );
      } else {
        app.showToast('請先安裝WeChat');
      }
    } else if (argument.isNotEmpty) {
      switch (linkType) {
        case 1:
          Get.toNamed('/pages/common/webview/index', parameters: {
            'src': argument,
          });
          break;
        case 2:
          Get.toNamed(argument);
          break;
        case 4:
          Get.toNamed('/pages/goods/detail/index', parameters: {
            'id': argument,
          });
          break;
      }
    }
  }
}

final App app = App.getInstance();
