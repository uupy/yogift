import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';

class DonationDetailController extends GetxController {
  final id = Get.parameters['id'];
  final title = ''.obs;

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

    update([
      'OrderDetailBaseInfo',
      'DeliveryInfoCard',
      'ExchangeTerms',
      'OrderItemCard',
    ]);
  }
}
