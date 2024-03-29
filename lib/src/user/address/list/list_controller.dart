import 'package:get/get.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/services/receiving_address.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class AddressListController extends GetxController {
  final listController = AppListController<ReceivingAddressVo>();
  ReceivingAddressVo? selected;

  Future<List<ReceivingAddressVo>> queryList(params) async {
    final res = await ReceivingAddressService.queryList(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    final list = items.map((e) => ReceivingAddressVo.fromJson(e)).toList();
    if (list.isNotEmpty && selected == null) {
      selected = list.first;
    }
    return list;
  }

  Future onReload() async {
    listController.onReload();
  }
}
