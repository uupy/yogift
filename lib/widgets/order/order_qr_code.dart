import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderQrCode extends StatefulWidget {
  final String code;

  /// 0 = 条形码， 1 = 二维码
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
    return BarcodeWidget(
      barcode: Barcode.qrCode(),
      data: widget.code,
      width: widget.width ?? 200.w,
      height: widget.height ?? 200.w,
    );
  }
}
