import 'package:get/get.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/services/gift.dart';

class PurchaseController extends GetxController {
  final goodsId = Get.parameters['id'];
  GiftDetailVo? detail;
  int currentStep = 1;

  void init() {
    fetchData();
  }

  Future fetchData() async {
    final res = await GiftService.getGift(goodsId!);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    update(['DetailInfo']);
  }
}
