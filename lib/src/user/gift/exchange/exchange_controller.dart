import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/src/order/constants.dart';

class GiftExchangeController extends GetxController {
  final id = Get.parameters['id'];
  final title = ''.obs;

  OrderDetailItemVo? detail;

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

  Future onExchange() async {
    final res = await UserOrderService.createWriteOffCode(id!);
    final data = res.data['data'] ?? {};

    detail!.writeoffCode = data['Writeoff_Code'];
    detail!.writeoffCodeType = data['Writeoff_CodeType'];
    update(['ExchangeInfo']);
  }
}
