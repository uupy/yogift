import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/order_list_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class OrderListController extends GetxController {
  final listController = AppListController<OrderListItemVo>();

  int orderStatus = 0;

  Future<List<OrderListItemVo>> queryList(params) async {
    params['orderstatus'] = orderStatus == -1 ? 0 : orderStatus;
    final res = await UserOrderService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => OrderListItemVo.fromJson(e)).toList();
  }

  Future onReload() async {
    listController.onReload();
  }

  Future onCloseOrder(String orderId) async {
    await UserOrderService.closeItem(orderId);
  }
}
