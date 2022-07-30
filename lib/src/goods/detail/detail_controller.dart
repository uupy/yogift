import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/services/gift.dart';

import 'widgets/free_one_tips.dart';

class GoodsDetailController extends GetxController {
  final goodsId = Get.parameters['id'];
  bool loading = false;
  int currentImageIndex = 0;
  GiftDetailVo? detail;

  void init() {
    if (goodsId != null) {
      fetchData();
    }
  }

  Future fetchData() async {
    final res = await GiftService.getGift(goodsId!);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    update();
    if (detail!.buy1Get1FREE == 1) {
      SmartDialog.show(
        alignment: Alignment.center,
        builder: (context) {
          return const FreeOneTips();
        },
      );
    }
  }

  void onImageChanged(int index) {
    currentImageIndex = index;
    update(['GoodsDetailImages']);
  }
}
