import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/common/app_theme.dart';

import 'app_storage.dart';

class App {
  App._internal();

  static App? _instance;

  factory App.getInstance() => _instance ??= App._internal();

  static FToast? fToast;

  /// 是否有网络
  bool hasNetWork = true;
  String deviceModel = '';

  Future init(BuildContext context) async {
    fToast ??= FToast();
    fToast?.init(context);
    await getDeviceModel();
  }

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

  Future<bool?> confirm({
    String? title,
    String? contentText,
    String? cancelText,
    String? confirmText,
    Widget? content,
    bool? barrierDismissible,
    bool? cupertinoStyle,
    BuildContext? context,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) async {
    Widget cancelBtn = Text(
      cancelText ?? '取消',
      style: const TextStyle(
        color: AppTheme.contentColor,
      ),
    );
    Widget confirmBtn = Text(
      confirmText ?? '确认',
      style: const TextStyle(
        color: AppTheme.primaryColor,
      ),
    );

    if (cupertinoStyle ?? false) {
      return await showDialog(
        context: context ?? Get.context!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title ?? '温馨提示'),
            content: content ?? Text(contentText ?? ''),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  onCancel?.call();
                  Get.back(result: false);
                },
                child: cancelBtn,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  onConfirm?.call();
                  Get.back(result: true);
                },
                child: confirmBtn,
              ),
            ],
          );
        },
      );
    }

    return await Get.defaultDialog(
      title: title ?? '温馨提示',
      content: content ?? Text(contentText ?? ''),
      radius: 8,
      barrierDismissible: barrierDismissible ?? true,
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Get.back(result: false);
          },
          child: cancelBtn,
        ),
        TextButton(
          onPressed: () {
            onConfirm?.call();
            Get.back(result: true);
          },
          child: confirmBtn,
        ),
      ],
    );
  }

  /// 退出登录
  Future logout() async {
    await authToken.remove();
    await loginUser.remove();
    if (Get.currentRoute != '/login') {
      Get.toNamed('/login');
    }
  }

  /// 检查相机权限
  Future showBottomModal<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      builder: builder,
    );
  }
}

final App app = App.getInstance();
