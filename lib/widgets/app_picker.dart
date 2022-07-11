import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef ItemBuilder<T> = Widget Function(T item, int index, bool selected);

class AppPicker<T> extends StatefulWidget {
  final String? title;
  final int? current;
  final List<T> items;
  final double? modalHeight;
  final Widget? child;
  final ItemBuilder<T> itemBuilder;
  final Function()? onCancel;
  final Function(T? selected)? onConfirm;
  final Function(int index)? onItemTap;

  const AppPicker({
    Key? key,
    required this.itemBuilder,
    this.items = const [],
    this.title,
    this.current,
    this.modalHeight,
    this.child,
    this.onCancel,
    this.onConfirm,
    this.onItemTap,
  }) : super(key: key);

  @override
  _AppPickerState createState() => _AppPickerState();
}

class _AppPickerState<T> extends State<AppPicker<T>> {
  int? _initCurrent;
  int? _current;

  @override
  void initState() {
    _current = _initCurrent = widget.current;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_initCurrent != widget.current) {
      _current = _initCurrent = widget.current;
      setState(() {});
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return StatefulBuilder(
              builder: (context, update) {
                return SizedBox(
                  height: widget.modalHeight ?? Get.height / 2,
                  child: Column(
                    children: [
                      buildModalHeader(),
                      Expanded(
                        child: buildModalBody(update),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: widget.child,
    );
  }

  Widget buildModalHeader() {
    return Container(
      height: 44.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color(0xffdddddd),
          ),
        ),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.back();
              widget.onCancel?.call();
            },
            child: const Text(
              '取消',
              style: TextStyle(
                color: AppTheme.contentColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              widget.onConfirm?.call(_current != null && _current != -1
                  ? widget.items[_current!]
                  : null);
            },
            child: const Text(
              '确认',
              style: TextStyle(
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildModalBody(void Function(void Function()) update) {
    final items = widget.items;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconFont.icon_no_data,
              size: 30.sp,
              color: AppTheme.descTextColor,
            ),
            const Text(
              '暂无数据',
              style: TextStyle(
                color: AppTheme.descTextColor,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (c, i) {
        final item = items[i];

        return GestureDetector(
          onTap: () {
            _current = i;
            update(() {});
            widget.onItemTap?.call(i);
          },
          behavior: HitTestBehavior.opaque,
          child: widget.itemBuilder(item, i, i == _current),
        );
      },
    );
  }
}
