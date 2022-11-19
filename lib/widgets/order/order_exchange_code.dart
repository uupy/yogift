import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'order_qr_code.dart';

class OrderExchangeCode extends StatefulWidget {
  final String? expirationTime;
  final String? giftName;
  final int? nums;
  final String? code;
  final int? codeType;
  final int? time;
  final Function()? onTimeout;

  const OrderExchangeCode({
    Key? key,
    this.expirationTime,
    this.giftName,
    this.nums,
    this.code,
    this.codeType,
    this.time,
    this.onTimeout,
  }) : super(key: key);

  @override
  _OrderExchangeCodeState createState() => _OrderExchangeCodeState();
}

class _OrderExchangeCodeState extends State<OrderExchangeCode> {
  Timer? timer;
  int countdown = 0;
  String timeString = '';

  String paddingZero(int val) {
    if (val < 10) {
      return '0$val';
    }
    return '$val';
  }

  void setTimeString() {
    final minutes = (countdown / 60).floor();
    final seconds = countdown % 60;
    final lastStr = '${paddingZero(seconds)}秒';

    setState(() {
      if (minutes > 0) {
        timeString = '${paddingZero(minutes)}分$lastStr';
      } else {
        timeString = lastStr;
      }
    });
  }

  void openTimer() {
    closeTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (_timer) {
      countdown--;
      setTimeString();
      if (countdown <= 0) {
        closeTimer();
        widget.onTimeout?.call();
      }
    });
  }

  void closeTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  void initState() {
    countdown = widget.time ?? 0;
    if (countdown > 0) {
      openTimer();
      setTimeString();
    }
    super.initState();
  }

  @override
  void dispose() {
    closeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeType = widget.codeType;
    final isQrCode = codeType == 1;
    final typeName = !isQrCode ? '條碼' : '二維碼';

    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: Column(
        children: [
          if(codeType == 0 || codeType == 1)
            Text(
              '請向店員出示以下$typeName掃描以兌換禮物',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ),
          if(codeType == 2)
            Text(
              '請於店内出示此頁面，讓店員輸入YO!GIFT兌換密碼',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ),

          SizedBox(height: 28.w),

          Text(
            '${widget.giftName ?? ''} X${widget.nums ?? 1}',
            style: TextStyle(fontSize: 14.sp),
          ),
          if (codeType == 0) SizedBox(height: 12.w),
          
          OrderQrCode(code: widget.code ?? '', type: codeType ?? 0),

          SizedBox(height: 6.w),
          if(codeType != 2)
            Text(
              '$typeName將於$timeString後失效，失效後將視為已兌換',
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
