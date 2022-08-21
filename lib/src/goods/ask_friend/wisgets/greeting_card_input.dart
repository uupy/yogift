import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_input.dart';

class GreetingCardInput extends StatelessWidget {
  final bool isEdit;
  final TextEditingController? controller;
  final Function(String? value)? onChanged;

  const GreetingCardInput({
    Key? key,
    this.isEdit = false,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInput(
      hintText: '',
      controller: controller,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 44.w,
      radius: Radius.circular(8.w),
      readOnly: !isEdit,
      textAlign: TextAlign.center,
      maxLength: 14,
      maxLines: 1,
      enableSuggestions: false,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        shadows: [
          Shadow(
            offset: Offset(0, 2.w),
            blurRadius: 4.w,
            color: const Color.fromRGBO(0, 0, 0, 0.65),
          ),
        ],
      ),
      cursorColor: Colors.white.withOpacity(0.65),
      backgroundColor:
          isEdit ? const Color.fromRGBO(0, 0, 0, 0.6) : Colors.transparent,
      onChanged: onChanged,
    );
  }
}
