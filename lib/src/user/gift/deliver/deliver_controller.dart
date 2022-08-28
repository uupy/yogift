import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';

class GiftDeliverController extends GetxController {
  final id = Get.parameters['id'];
  final title = ''.obs;

  OrderDetailItemVo? detail;

  bool get isThirdParty {
    return detail?.sendingMethod == 3;
  }

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
      'ExchangeInfo',
      'GreetingCard',
      'ExchangeTerms',
      'OrderItemCard',
      'OrderDetailFooter'
    ]);
  }
}
