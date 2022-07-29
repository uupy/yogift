import 'package:get/get.dart';
import 'package:yo_gift/models/brand.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/brand.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class ShopDetailController extends GetxController {
  final brandId = Get.parameters['id'];
  final listController = AppListController<GiftVo>();
  BrandBussinessVo? detail;
  String? giftName;

  Future fetchData() async {
    final res = await BrandService.getItem(brandId!);
    final data = res.data ?? {};
    detail = BrandBussinessVo.fromJson(data['data'] ?? {});
    listController.onReload();
    update();
  }

  Future<List<GiftVo>> queryList(Map<String, dynamic> params) async {
    params['bussinessno'] = detail?.bussinessNo;
    if (giftName != null) {
      params['giftname'] = giftName;
    }
    final res = await GiftService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => GiftVo.fromJson(e)).toList();
  }

  void onFilterChange(String value) {
    giftName = value;
    listController.onReload();
  }
}
