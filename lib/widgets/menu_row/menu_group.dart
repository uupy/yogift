import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_card.dart';

import 'menu_item.dart';
import 'menu_row.dart';

class MenuGroup extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? blurRadius;
  final List<MenuItem>? menus;
  final List<Widget>? children;
  final Function(String key)? onTap;
  final Function(dynamic value)? onBack;

  const MenuGroup({
    Key? key,
    this.margin,
    this.padding,
    this.blurRadius,
    this.menus,
    this.children,
    this.onTap,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = menus ?? [];

    return AppCard(
      width: double.maxFinite,
      margin: margin ?? EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.w),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
      blurRadius: blurRadius ?? 2.r,
      child: Column(
        children: children ??
            _items.asMap().keys.map((index) {
              final item = _items[index];
              return MenuRow(
                icon: item.icon,
                label: item.label,
                arrow: item.showArrow,
                showBottomBorder: index != _items.length - 1,
                onTap: () {
                  if (item.path?.isNotEmpty ?? false) {
                    Get.toNamed(item.path!, parameters: item.parameters)
                        ?.then((value) {
                      onBack?.call(value);
                    });
                  } else if (item.key?.isNotEmpty ?? false) {
                    onTap?.call(item.key!);
                  }
                },
              );
            }).toList(),
      ),
    );
  }
}
