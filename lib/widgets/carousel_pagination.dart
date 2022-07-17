import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class CarouselPagination extends StatefulWidget {
  final int current;
  final int itemsCount;
  final double? size;
  final double? activeSize;
  final Color? color;
  final Color? activeColor;
  final EdgeInsetsGeometry? margin;
  final double? space;
  final AlignmentGeometry? alignment;

  const CarouselPagination({
    Key? key,
    this.current = 0,
    this.itemsCount = 0,
    this.size,
    this.activeSize,
    this.color,
    this.activeColor,
    this.margin,
    this.space,
    this.alignment,
  }) : super(key: key);

  @override
  _CarouselPagination createState() => _CarouselPagination();
}

class _CarouselPagination extends State<CarouselPagination> {
  double space = 8.w;
  double size = 8.w;
  double activeSize = 8.w;
  Color color = const Color(0xffffffff);
  Color activeColor = AppTheme.primaryColor;

  @override
  void initState() {
    space = widget.space ?? space;
    size = widget.size ?? size;
    activeSize = widget.activeSize ?? activeSize;
    color = widget.color ?? color;
    activeColor = widget.activeColor ?? activeColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      alignment: widget.alignment,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.itemsCount, (index) {
          return Container(
            width: widget.current == index ? activeSize : size,
            height: size,
            margin: EdgeInsets.symmetric(horizontal: space / 2),
            decoration: BoxDecoration(
              color: widget.current == index ? activeColor : color,
              borderRadius: BorderRadius.circular(size),
            ),
          );
        }),
      ),
    );
  }
}
