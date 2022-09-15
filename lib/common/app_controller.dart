import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/common/utils.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/services/common.dart';

class AppController extends GetxController {
  BuildContext? _context;
  Function? _completeCallback;

  /// 当前版本号
  String currentVersion = '';

  /// 下载进度
  final updateProgress = '0'.obs;

  /// 新版本信息
  Map? newVersionInfo;

  /// 是否有新版本
  bool hasNewVersion = false;

  /// 包的下载地址
  String fileUrl = '';

  /// 全局配置信息
  AppConfigVo? config;

  /// 完成回调（不论成功，失败，还是取消）
  handleComplete([data]) {
    _completeCallback?.call(data);
  }

  /// 应用初始化
  Future init(
      {Function(dynamic)? onComplete, Function(dynamic)? onError}) async {
    _completeCallback = onComplete;
    try {
      final res = await CommonService.getConfig();
      final data = res.data['data'] ?? {};
      config = AppConfigVo.fromJson(data);
      update();
    } catch (e) {
      onError?.call(e);
    } finally {
      handleComplete();
    }
  }

  /// 检查更新
  Future<void> checkUpdate(
    BuildContext context, {
    Function(dynamic)? onComplete,
  }) async {
    _context = context;
    _completeCallback = onComplete;
    try {
      currentVersion = await CommonUtils.getCurrentVersion();
      // final res = await CommonService.queryNewVersion({
      //   'terminalType': Platform.isAndroid ? 0 : 1,
      //   'currentVersion': currentVersion,
      // });
      final data = {};
      newVersionInfo = data['data'];
      if (newVersionInfo != null) {
        fileUrl = newVersionInfo!['fileUrl'];
        if (fileUrl.isNotEmpty) {
          hasNewVersion = true;
          showUpdateTipsDialog();
        } else {
          handleComplete(data);
        }
      } else {
        handleComplete(data);
      }
    } catch (err) {
      handleComplete(err);
    }
  }

  /// 更新提示
  showUpdateTipsDialog() {
    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('版本更新'),
          content: Text(
            '版本：${newVersionInfo!['version']} \n ${newVersionInfo!['content']}',
          ),
          actions: [
            if (newVersionInfo!['upgradeType']['value'] != 0)
              TextButton(
                onPressed: () {
                  Get.back();
                  handleComplete();
                },
                child: const Text(
                  '取消',
                  style: TextStyle(color: AppTheme.descTextColor),
                ),
              ),
            TextButton(
              onPressed: () {
                Get.back();
                handleUpdateApp();
              },
              child: const Text(
                '更新',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 更新操作
  Future<void> handleUpdateApp() async {
    if (Platform.isAndroid) {
      downLoadApk();
    } else {
      handleComplete();

      /// iOS 跳转商店
      if (await canLaunchUrl(Uri(path: fileUrl))) {
        await launchUrl(Uri(path: fileUrl));
      } else {
        app.showToast('无法跳转应用商店');
      }
    }
  }

  /// 安卓包下载
  Future<void> downLoadApk() async {
    showDialog(
      context: _context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('版本更新'),
          content: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 100,
            child: Column(
              children: [
                const Text('正在更新中...'),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  child: Obx(
                    () => Text(
                      '${updateProgress.value}%',
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: const [],
        );
      },
    );
    try {
      OtaUpdate().execute(fileUrl, destinationFilename: 'warehouse.apk').listen(
        (OtaEvent event) {
          if (event.value != '' && event.value != null) {
            updateProgress.value = event.value!;
            if (updateProgress.value == '100') {
              handleComplete();
            }
          }
        },
      );
    } catch (e) {
      logger.e('Failed to make OTA update. Details: $e');
      handleComplete();
    }
  }
}
