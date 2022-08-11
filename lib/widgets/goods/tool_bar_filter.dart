import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'tool_bar_button.dart';

class GoodsFilterMenuItem {
  GoodsFilterMenuItem({required this.name, this.icon});
  final String name;
  final String? icon;
}

class GoodsToolBarFilter extends StatefulWidget {
  final int? value;
  final Color? buttonBorderColor;
  final Function(int index)? onChanged;

  const GoodsToolBarFilter({
    Key? key,
    this.value,
    this.buttonBorderColor,
    this.onChanged,
  }) : super(key: key);

  @override
  _GoodsToolBarFilterState createState() => _GoodsToolBarFilterState();
}

class _GoodsToolBarFilterState extends State<GoodsToolBarFilter> {
  final sortController = CustomPopupMenuController();
  final menuItems = [
    GoodsFilterMenuItem(name: '到店兌換', icon: 'icon_get_type_1_2.png'),
    GoodsFilterMenuItem(name: '免費送貨', icon: 'icon_get_type_2_2.png'),
    GoodsFilterMenuItem(name: '網上兌換', icon: 'icon_get_type_3_2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      child: IgnorePointer(
        child: GoodsToolBarButton(
          text: '篩選',
          icon: 'icon_filter.png',
          borderColor: widget.buttonBorderColor,
        ),
      ),
      arrowColor: Colors.white,
      barrierColor: Colors.transparent,
      verticalMargin: 5,
      menuBuilder: () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2.w),
              blurRadius: 16.w,
              color: const Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ],
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems.asMap().keys.map(
              (index) {
                final item = menuItems[index];

                return buildMenuItem(
                  name: item.name,
                  icon: item.icon,
                  index: index,
                  onTap: () {
                    sortController.hideMenu();
                    widget.onChanged?.call(index);
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      controller: sortController,
    );
  }

  Widget buildMenuItem({
    required String name,
    required int index,
    String? icon,
    Function()? onTap,
  }) {
    bool isActive = widget.value == index + 1;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: 220.w,
        height: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: index > 0
                  ? const Color.fromRGBO(230, 230, 230, 0.3)
                  : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          children: [
            AppAssetImage(
              width: 16.w,
              margin: EdgeInsets.only(right: 4.w),
              img: icon,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 12.sp,
                color: isActive ? const Color(0xff007aff) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
