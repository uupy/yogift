import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/services/gift.dart';

import 'widgets/free_one_tips.dart';
import 'widgets/sku_select_view.dart';

class GoodsDetailController extends GetxController {
  final goodsId = Get.parameters['id'];
  final buyType = Get.parameters['buyType'];
  bool loading = false;
  int currentImageIndex = 0;
  GiftDetailVo? detail;
  Skus selectSku = Skus(id: 0);

  void init() async {
    if (goodsId != null) {
      fetchData();
    }
  }

  /// 跳转页面
  void navTo(String type, [Function()? cb]) {
    String routeName = '';

    if (type == '2') {
      routeName = '/pages/goods/purchase/index';
    } else if (type == '3') {
      routeName = '/pages/goods/ask-friend/index';
    }
    if (routeName.isNotEmpty) {
      final parameters = Get.parameters.cast<String, String>();
      Get.toNamed(routeName, parameters: parameters)?.then((value) {
        cb?.call();
      });
    }
  }

  void showSkuModal() {
    app.showBottomModal(
      context: Get.context!,
      // isScrollControlled: false,
      builder: (context) {
        return SkuSelectView();
      },
    );
  }

  /// 显示买一赠一提示弹窗
  void showTips() {
    if (detail!.buy1Get1FREE == 1) {
      SmartDialog.show(
        alignment: Alignment.center,
        builder: (context) {
          return const FreeOneTips();
        },
      );
    }
  }

  /// 获取商品详情
  Future fetchData() async {
    final res = await GiftService.getGift(goodsId!);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    update();

    if (buyType != null) {
      if (detail!.skuType == 1) {
        showSkuModal();
      } else {
        navTo(buyType!, showTips);
      }
    } else {
      showTips();
    }
  }

  /// 切换图片
  void onImageChanged(int index) {
    currentImageIndex = index;
    update(['GoodsDetailImages']);
  }
}
