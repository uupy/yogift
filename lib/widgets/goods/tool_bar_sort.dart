import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'tool_bar_button.dart';

class GoodsToolBarSort extends StatefulWidget {
  final int? value;
  final Color? buttonBorderColor;
  final Function(int index)? onChanged;

  const GoodsToolBarSort({
    Key? key,
    this.value,
    this.buttonBorderColor,
    this.onChanged,
  }) : super(key: key);

  @override
  _GoodsToolBarSortState createState() => _GoodsToolBarSortState();
}

class _GoodsToolBarSortState extends State<GoodsToolBarSort> {
  final sortController = CustomPopupMenuController();
  final menuItems = ['按人氣排序', '按推薦排序', '按新至舊排序', '價錢低至高排序', '價錢高至低排序'];

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      child: IgnorePointer(
        child: GoodsToolBarButton(
          text: '排序',
          icon: 'icon_sort.png',
          borderColor: widget.buttonBorderColor,
        ),
      ),
      arrowColor: Colors.white,
      barrierColor: Colors.transparent,
      verticalMargin: 5.w,
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
                return buildMenuItem(
                  name: menuItems[index],
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
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12.sp,
              color: isActive ? const Color(0xff007aff) : null,
            ),
          ),
        ),
      ),
    );
  }
}
