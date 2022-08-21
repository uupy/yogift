import 'package:get/get.dart';
import 'package:yo_gift/models/user_order/donation_item.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class DonationRecordController extends GetxController {
  final listController = AppListController<DonationItemVo>();

  Future<List<DonationItemVo>> queryList(params) async {
    final res = await UserOrderService.queryPageForCharity(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => DonationItemVo.fromJson(e)).toList();
  }

  Future onReload() async {
    listController.onReload();
  }
}
