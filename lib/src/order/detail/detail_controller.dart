import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';

class OrderDetailController extends GetxController {
  final id = Get.parameters['id'];
  final title = ''.obs;

  OrderDetailItemVo? detail;

  bool get isThirdParty {
    return detail?.sendingMethod == 1;
  }

  bool get isOnline {
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
      'ExchangeCode',
      'ExchangeInfo',
      'GreetingCard',
      'ExchangeTerms',
      'OrderItemCard',
      'OrderDetailFooter'
    ]);
  }

  Future onCloseOrder() async {
    final res = await app.confirm(contentText: '確定關閉該訂單嗎?');
    if (res == true) {
      await UserOrderService.closeItem(detail!.oGuid!);
      app.showToast('該訂單已關閉');
    }
    Get.back();
  }
}
