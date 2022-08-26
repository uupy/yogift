import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/pay/pay_controller.dart';

class CharityPayController extends GetxController {
  final orderId = Get.parameters['orderId'];

  OrderDetailItemVo? detail;

  Future fetchData() async {
    final res = await UserOrderService.getItem(orderId!);
    final data = res.data ?? {};

    detail = OrderDetailItemVo.fromJson(data['data'] ?? {});

    update([
      'CharityPayFooter',
      'DeliveryInfoCard',
      'OrderItemCard',
    ]);
  }

  Future onPay() async {
    if (detail != null) {
      final payController = Get.put(PayController());
      await payController.showModal(detail!.oGuid!);
    }
  }
}
