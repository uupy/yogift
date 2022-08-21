import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopNameLink extends StatelessWidget {
  final String name;
  final String? id;
  const ShopNameLink({Key? key, required this.name, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id?.isNotEmpty ?? false) {
          Get.toNamed('/pages/shop/detail/index', parameters: {
            'id': id!,
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xff007aff),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
