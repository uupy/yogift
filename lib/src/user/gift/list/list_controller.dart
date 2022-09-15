import 'package:get/get.dart';
import 'package:yo_gift/models/give.dart';
import 'package:yo_gift/services/give.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class GiftListController extends GetxController {
  final listController = AppListController<GiveItemVo>();

  Future<List<GiveItemVo>> queryList(params) async {
    final res = await GiveService.queryAcceptPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => GiveItemVo.fromJson(e)).toList();
  }

  Future onReload() async {
    listController.onReload();
  }

  Future onBackRefresh() async {
    listController.onBackRefresh();
  }
}
