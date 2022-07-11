import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseFormDialog {
  StateSetter? _reloadStateSetter;
  BuildContext? _context;
  bool isLoading = false;
  dynamic _state;

  /// 打开弹窗
  open(BuildContext context, {state}) {
    _state = state;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        _context = context;
        return StatefulBuilder(builder: (context, stateSetter) {
          _reloadStateSetter = stateSetter;
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.fromLTRB(0, 5.h, 0, 10.h),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    buildTitle(state),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.w,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                buildBody(),
              ],
            ),
            actions: [
              Container(
                margin: EdgeInsets.fromLTRB(13.w, 0, 13.w, 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButton(
                      '取消',
                      onPressed: () {
                        _handleCancel();
                      },
                    ),
                    buildButton(
                      isLoading ? '提交中...' : '确定',
                      primary: true,
                      margin: EdgeInsets.only(left: 15.w),
                      onPressed: () {
                        _handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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

  dynamic get state => _state;

  /// 对话框标题
  String buildTitle(state) {
    return '';
  }

  /// 对话框内容
  Widget buildBody() {
    return Container();
  }

  Future onSubmit() async {}

  void update(void Function() hook) {
    _reloadStateSetter?.call(hook);
  }

  void onClose() {
    isLoading = false;
  }

  void submitSuccessCallback() {
    onClose();
    Navigator.of(_context!).pop(true);
    app.toastSuccess('操作成功');
  }

  void _handleCancel() {
    onClose();
    Navigator.of(_context!).pop(false);
  }

  void _handleSubmit() async {
    if (isLoading) return;
    update(() {
      isLoading = true;
    });
    try {
      await onSubmit();
      submitSuccessCallback();
    } catch (err) {
      logger.e(err);
    } finally {
      update(() {
        isLoading = false;
      });
    }
  }
}
