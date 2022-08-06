import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'tool_bar_button.dart';

class MenuItem {
  MenuItem({required this.name, this.icon});
  final String name;
  final String? icon;
}

class ToolBarFilter extends StatefulWidget {
  final int? value;
  final Function(int index)? onChanged;

  const ToolBarFilter({
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _ToolBarFilterState createState() => _ToolBarFilterState();
}

class _ToolBarFilterState extends State<ToolBarFilter> {
  final sortController = CustomPopupMenuController();
  final menuItems = [
    MenuItem(name: '到店兌換', icon: 'icon_get_type_1_2.png'),
    MenuItem(name: '免費送貨', icon: 'icon_get_type_2_2.png'),
    MenuItem(name: '網上兌換', icon: 'icon_get_type_3_2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      child: const IgnorePointer(
        child: ToolBarButton(
          text: '篩選',
          icon: 'icon_filter.png',
        ),
      ),
      arrowColor: Colors.white,
      barrierColor: Colors.transparent,
      verticalMargin: 5,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
