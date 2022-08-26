import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_input.dart';

class OrderRemark extends StatelessWidget {
  final Function(String? value)? onChanged;

  const OrderRemark({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w),
            child: Text(
              '訂單備註（選填）',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
          ),
          AppInput(
            hintText: '請輸入備註或特別要求',
            maxLines: 3,
            maxLength: 100,
            height: 76.w,
            style: TextStyle(
              fontSize: 14.sp,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
