import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef CustomBuilder = Widget Function(Function(void Function()) stateSetter);

class AppDialog {
  AppDialog._internal();

  static AppDialog? _instance;

  factory AppDialog.getInstance() => _instance ??= AppDialog._internal();

  bool isLoading = false;

  /// 打开弹窗
  open({
    String? title,
    Widget? content,
    CustomBuilder? contentBuilder,
    Function()? onCancel,
    Future Function()? onOk,
  }) {
    return showDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, stateSetter) {
            return AlertDialog(
              title: Text(
                title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.w,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              content: content ?? contentBuilder?.call(stateSetter),
              actions: [
                Container(
                  margin: EdgeInsets.fromLTRB(13.w, 0, 13.w, 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton(
                        '取消',
                        onPressed: () {
                          onCancel?.call();
                          Get.back(result: false);
                        },
                      ),
                      buildButton(
                        isLoading ? '提交中...' : '确定',
                        primary: true,
                        margin: EdgeInsets.only(left: 15.w),
                        onPressed: () async {
                          if (isLoading) return;
                          stateSetter(() {
                            isLoading = true;
                          });
                          try {
                            await onOk?.call();
                            Get.back(result: true);
                          } catch (e) {
                            logger.e('app dialog submit error: $e');
                          } finally {
                            stateSetter(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 对话框按钮
  Widget buildButton(
    String text, {
    bool? primary,
    EdgeInsetsGeometry? margin,
    Function()? onPressed,
  }) {
    return Container(
      margin: margin,
      width: 110.w,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            primary == true
                ? AppTheme.primaryColor
                : AppTheme.primaryColor.withOpacity(0.15),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.fromLTRB(20.w, 15.w, 20.w, 15.w),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: primary == true ? Colors.white : AppTheme.primaryColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

AppDialog appDialog = AppDialog.getInstance();
