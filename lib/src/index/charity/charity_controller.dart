import 'package:get/get.dart';
import 'package:yo_gift/models/charity.dart';
import 'package:yo_gift/services/charity.dart';

class CharityController extends GetxController {
  List<CharityListItemVo> list = [];

  @override
  void onInit() {
    queryList();
    super.onInit();
  }

  Future queryList() async {
    final res = await CharityService.queryCharityList();
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    list = items.map((e) => CharityListItemVo.fromJson(e)).toList();
    update();
  }
}
