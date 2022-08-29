import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'order_qr_code.dart';

class OrderExchangeCode extends StatelessWidget {
  final String? expirationTime;
  final String? giftName;
  final int? nums;
  final String? code;
  final int? codeType;
  const OrderExchangeCode({
    Key? key,
    this.expirationTime,
    this.giftName,
    this.nums,
    this.code,
    this.codeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: Column(
        children: [
          Text(
            '請向店員出示以下${codeType == 0 ? '條碼' : '二維碼'}掃描以兌換禮物',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
          SizedBox(height: 28.w),
          Text(
            '${giftName ?? ''} X${nums ?? 1}',
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 12.w),
          OrderQrCode(code: code ?? '', type: codeType ?? 0),
          SizedBox(height: 4.w),
          Text(
            '條碼掃將於${expirationTime ?? ''}後失效，失效後將視為已兌換',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xffff3b30),
            ),
          ),
        ],
      ),
    );
  }
}
