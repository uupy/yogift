import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_theme.dart';

/// 配置MaterialApp主题
final ThemeData appThemeData = ThemeData(
  // primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,

  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: AppTheme.primaryColor,
    titleTextStyle: TextStyle(
      color: Colors.black.withOpacity(0.9),
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Colors.black.withOpacity(0.9)),
  ),

  textTheme: TextTheme(
    button: const TextStyle(color: Colors.white),
    bodyText2: TextStyle(fontSize: 15.sp, color: const Color(0xff333333)),
  ),

  /// 输入框
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.fromLTRB(12.w, 15.h, 12.w, 15.h),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black45,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54),
    ),
  ),

  /// 字体主题
  iconTheme: const IconThemeData(),

  /// 有背景的button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(
        AppTheme.primaryColor,
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 15.sp,
          color: const Color.fromRGBO(0, 0, 0, 0.9),
        ),
      ),
    ),
  ),

  /// 有边框的button
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 40.h)),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 15.sp),
      ),
      foregroundColor: MaterialStateProperty.all(AppTheme.primaryColor),
      side: MaterialStateProperty.all(
        const BorderSide(
          color: AppTheme.primaryColor,
          width: 1,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    ),
  ),

  /// TextButton 无边框无背景
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(20.w, 20.h),
        ),
        visualDensity: VisualDensity.compact,
        padding: MaterialStateProperty.all(
          EdgeInsets.zero,
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white)),
  ),

  /// 卡片主题
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      ),
    ),
  ),

  dividerTheme: const DividerThemeData(
    thickness: 0.5,
    space: 0,
    color: AppTheme.dividerColor,
  ),
);
