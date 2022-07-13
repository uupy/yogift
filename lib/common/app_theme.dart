import 'package:flutter/material.dart';

/// 应用主题
class AppTheme {
  AppTheme._();

  /// 主题色
  static const Color primaryColor = Color(0xffffe100);

  /// 成功颜色
  static const Color successColor = Color(0xff00C227);

  /// 状态正常颜色
  static const Color healthColor = Color(0xff67C23A);

  /// 报警颜色
  static const Color alarmColor = Color(0xffF57171);

  /// 警告颜色
  static const Color warningColor = Color(0xffE0BB7C);

  /// 标题文本颜色
  static const Color titleColor = Colors.black;

  /// 内容文本颜色
  static const Color contentColor = Color(0xff333333);

  /// 内容文本颜色
  static const Color subColor = Color(0xff666666);

  /// 描述文本颜色
  static const Color descTextColor = Color(0xff999999);

  /// 页面背景色
  static const Color bodyBackgroundColor = Color(0xffEDEFFE);

  /// 分割线颜色
  static const Color dividerColor = Color(0xffEBEBEB);

  /// 边框颜色
  static const Color borderColor = Color(0xff333333);

  /// tab 背景色
  static const Color tabBackgroundColor = Color(0xffF5F1ED);
}
