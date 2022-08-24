import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_button.dart';

class OrderItemFooter extends StatelessWidget {
  final String? date;

  const OrderItemFooter({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String tips = '預計${date ?? ''}送達';
    Color tipsColor = const Color.fromRGBO(0, 0, 0, 0.9);
    List<Widget> children = [];

    children.addAll([
      buildFooterItem(
        text: '查看詳情',
        background: const Color(0xfffffdeb),
      ),
    ]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            tips,
            style: TextStyle(color: tipsColor),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget buildFooterItem({
    String? text,
    Color? background,
    Function()? onTap,
  }) {
    return Container(
      width: 96.w,
      height: 32.w,
      margin: EdgeInsets.only(left: 10.w),
      child: AppButton(
        backgroundColor: background,
        text: text,
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color.fromRGBO(0, 0, 0, 0.9),
        ),
      ),
    );
  }
}
