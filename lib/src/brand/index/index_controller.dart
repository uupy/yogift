import 'package:get/get.dart';
import 'package:yo_gift/models/brand.dart';
import 'package:yo_gift/services/brand.dart';

class BrandIndexController extends GetxController {
  List<BrandBussinessVo> list = [];
  List<dynamic> list1 = [];

  @override
  void onInit() {
    queryList();
    super.onInit();
  }

  Future queryList() async {
    final res = await BrandService.queryBrandList();
    final data = res.data ?? {};
    final List items = data['data'] ?? [];

    list = items.map((e) => BrandBussinessVo.fromJson(e)).toList();
    update();
  }
}
