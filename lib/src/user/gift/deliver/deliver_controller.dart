import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';

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
}
