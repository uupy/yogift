import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

import 'app_storage.dart';
import 'custom_dialog/custom_dialog.dart';

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
    List<Widget>? actions,
    bool? barrierDismissible,
    bool? cupertinoStyle,
    BuildContext? context,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) async {
    return await showAnimationDialog<bool>(
      context: Get.context!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 182.w,
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
                        child: Text(title ?? ''),
                      ),
                      Positioned(
                        top: 15.w,
                        right: 20.w,
                        child: AppAssetImage(
                          width: 16.w,
                          img: 'icon_close.png',
                          onTap: () {
                            Get.back(result: false);
                            onCancel?.call();
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

  /// 退出登录
  Future logout({Function()? success}) async {
    await authDataStorage.remove();
    await accessToken.remove();
    await loginUser.remove();

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
}

final App app = App.getInstance();
