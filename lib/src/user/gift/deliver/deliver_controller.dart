import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

class GiftDeliverController extends GetxController {
  final id = Get.parameters['id'];
  final title = ''.obs;
  int currentStep = 1;
  bool submitting = false;

  OrderDetailItemVo? detail;

  bool get isExchanged {
    return detail?.payStatus == 2 && detail?.orderStatus == 4;
  }

  bool get isGifted {
    return detail?.payStatus == 2 && detail?.orderStatus == 8;
  }

  bool get isEmptyAddress {
    final address = detail?.receivingaddressAddress ?? '';
    final area0 = detail?.receivingaddressArea0 ?? '';
    final name = detail?.receivingaddressContact ?? '';
    final phone = detail?.receivingaddressPhone ?? '';

    return address.isEmpty && area0.isEmpty && name.isEmpty && phone.isEmpty;
  }

  Future fetchData() async {
    final res = await UserOrderService.getItem(id!);
    final data = res.data ?? {};

    detail = OrderDetailItemVo.fromJson(data['data'] ?? {});
    title(OrderStatus.getLabelByValue(detail?.orderStatus));

    if (detail?.orderStatus == 2) {
      currentStep = 2;
    } else if (detail?.orderStatus == 3) {
      currentStep = 3;
    } else if (detail?.orderStatus == 4) {
      currentStep = 4;
    }

    update();
  }

  /// 確認收貨
  Future onReceivingConfirm() async {
    submitting = true;
    update();
    try {
      await UserOrderService.receivingConfirm(id!);
      fetchData();
    } finally {
      submitting = false;
      update();
    }
  }

  /// 修改訂單收貨地址
  Future updateReceivingAddress(int addressId) async {
    await UserOrderService.updateReceivingAddressById(id!, addressId);
    fetchData();
  }

  /// 確認收貨地址
  Future confirmReceivingAddress() async {
    await UserOrderService.confirmReceivingAddress(id!);
    fetchData();
  }

  void showAddressInfo(ReceivingAddressVo? addr) {
    if (addr != null) {
      app.confirm(
        height: 270.w,
        title: '確認收貨信息',
        cancelText: '修改信息',
        confirmText: '我已確認，提交',
        content: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSimpleRow(
                margin: EdgeInsets.only(bottom: 11.w),
                label: '收貨地址',
                labelColor: const Color.fromRGBO(0, 0, 0, 0.26),
                labelWidth: 70.w,
                content: '${addr.area0}${addr.area1}${addr.address}',
              ),
              AppSimpleRow(
                margin: EdgeInsets.only(bottom: 11.w),
                label: '聯繫人',
                labelColor: const Color.fromRGBO(0, 0, 0, 0.26),
                labelWidth: 70.w,
                content: '${addr.contact}',
              ),
              AppSimpleRow(
                margin: EdgeInsets.only(bottom: 11.w),
                label: '聯繫電話',
                labelColor: const Color.fromRGBO(0, 0, 0, 0.26),
                labelWidth: 70.w,
                content: '${addr.phone}',
              ),
              Text(
                '請確認配送信息無誤，一旦確認不可修改',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xffff8d00),
                ),
              ),
            ],
          ),
        ),
        onCancel: () {
          goSelectAddress();
        },
        onConfirm: () {
          confirmReceivingAddress();
        },
      );
      if (addr.id != null) {
        updateReceivingAddress(addr.id!);
      }
    }
  }

  void goSelectAddress() {
    Get.toNamed('/pages/mine/addr-setting/index')?.then((value) {
      showAddressInfo(value);
    });
  }
}
