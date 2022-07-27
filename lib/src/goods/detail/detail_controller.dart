import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';

class GoodsDetailController extends GetxController {
  bool loading = false;
  int currentImageIndex = 0;
  GiftVo? detail;

  void onImageChanged(int index) {
    currentImageIndex = index;
    update(['GoodsDetailImages']);
  }
}
