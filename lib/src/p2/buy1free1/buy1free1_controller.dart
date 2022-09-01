import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/gift.dart';

class P2Buy1Free1Controller extends GetxController {
  List<GiftVo> list = [];

  Future queryList() async {
    final res = await GiftService.queryPage({
      'buy1get1free': 1,
      'pageindex': 1,
      'pagesize': 999,
    });
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    list = items.map((e) => GiftVo.fromJson(e)).toList();
    update(['GiftList']);
  }
}
