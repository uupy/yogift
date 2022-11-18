import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/src/user/gift/exchange/exchange_controller.dart';

class OrderQrCode extends StatefulWidget {
  final String code;

  /// 0 = 条形码， 1 = 二维码  2 = 兌換碼
  final int type;
  final double? width;
  final double? height;

  const OrderQrCode({
    Key? key,
    required this.code,
    this.type = 0,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _OrderQrCodeState createState() => _OrderQrCodeState();
}

class _OrderQrCodeState extends State<OrderQrCode> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == 0) {
      return BarcodeWidget(
        barcode: Barcode.code128(),
        data: widget.code,
        width: widget.width ?? 200.w,
        height: widget.height ?? 88.w,
      );
    }
    if (widget.type == 1) {
      return BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: widget.code,
        width: widget.width ?? 200.w,
        height: widget.height ?? 200.w,
      );
    }

    return GetBuilder<GiftExchangeController>(
      id: 'exchangeVerifyCode',
      builder: (c) {
        return Container(
          margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
          child: Column(
            children: [
              VerificationCode(
                textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
                keyboardType: TextInputType.number,
                fullBorder: true,
                underlineColor: Colors.amber,
                length: 4,
                cursorColor: Colors.blue,
                onCompleted: (String value) {
                  c.onExchangeByCode(value);
                },
                onEditing: (bool value) {},
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                '密碼為4位數字',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
