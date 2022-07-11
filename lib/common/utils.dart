import 'dart:async';

import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart'
    if (dart.library.html) 'package:package_info_plus/package_info_plus.dart';

class CommonUtils {
  CommonUtils._();

  static bool isNumber(String value) {
    String source = value.replaceAll(',', '');

    return double.tryParse(source) != null;
  }

  static String formatDate(DateTime datetime, String newPattern) {
    final fmt = DateFormat(newPattern, 'en_US');
    return fmt.format(datetime);
  }

  static String formatDateByString(String? date, String newPattern) {
    if (date == null) {
      return '';
    }
    return CommonUtils.formatDate(DateTime.parse(date), newPattern);
  }

  static String formatDateRange(String? beginTime, String? endTime) {
    if (beginTime == null || endTime == null) {
      return '';
    }
    DateTime begin = DateTime.parse(beginTime);
    DateTime end = DateTime.parse(endTime);
    String bt = CommonUtils.formatDate(begin, 'HH:mm');
    String et = CommonUtils.formatDate(end, 'HH:mm');
    String ed = CommonUtils.formatDate(end, 'dd/MM/yyyy');
    return '$bt-$et $ed';
  }

  static String formatCurrency(double number) {
    final fmt = NumberFormat('#,##0.00', 'en_US');
    return fmt.format(number);
  }

  static String trimZero(String value) {
    if (value.contains('.')) {
      final last = value[value.length - 1];
      if (['0', '.'].contains(last)) {
        return CommonUtils.trimZero(value.substring(0, value.length - 1));
      }
    }
    return value;
  }

  static String formatWeight(double number) {
    final fmt = NumberFormat('#,##0.000', 'en_US');
    return CommonUtils.trimZero(fmt.format(number));
  }

  static String? emptyValidator(String? value) {
    String str = value ?? '';
    return str.isEmpty ? '必填项不能为空' : null;
  }

  static String? emilValidator(String? value) {
    String str = value ?? '';
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    bool hasMatch = RegExp(regexEmail).hasMatch(str);
    if (str.isEmpty) {
      return 'please enter';
    } else if (!hasMatch) {
      return 'error';
    }
    return null;
  }

  static String? noSpacesValidator(String? value) {
    final reg = RegExp(r'[\s]');
    final str = value ?? '';
    if (str.isEmpty) {
      return '必填项不能为空';
    } else if (reg.hasMatch(str)) {
      return '不能包含空格符';
    }
    return null;
  }

  static getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  /// 获取当前app版本
  static getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static debounce(Function(dynamic data)? func,
      [Duration delay = const Duration(milliseconds: 300)]) {
    Timer? timer;
    return (dynamic data) {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func?.call(data);
      });
    };
  }
}
