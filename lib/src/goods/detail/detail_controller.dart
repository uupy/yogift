import 'package:get/get.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/services/gift.dart';

class GoodsDetailController extends GetxController {
  final goodsId = Get.arguments;
  bool loading = false;
  int currentImageIndex = 0;
  GiftDetailVo? detail;

  void init() {
    fetchData();
  }

  Future fetchData() async {
    final res = await GiftService.getGift(goodsId);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    update();
  }

  void onImageChanged(int index) {
    currentImageIndex = index;
    update(['GoodsDetailImages']);
  }
}
