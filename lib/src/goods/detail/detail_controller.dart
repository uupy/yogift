import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/services/gift.dart';

import 'widgets/free_one_tips.dart';
import 'widgets/gift_method_select_view.dart';
import 'widgets/sku_select_view.dart';

class GoodsDetailController extends GetxController {
  String goodsId = Get.parameters['id'] ?? '';

  /// '1' = 赠送给自己， '2' = 赠送给好友， '3' = 拜托好友
  String buyType = Get.parameters['buyType'] ?? '';
  bool loading = false;
  int currentImageIndex = 0;
  GiftDetailVo? detail;
  List<String> selectSkuKeys = [];

  Skus get selectSku {
    final selectKey = selectSkuKeys.join('-');
    final skuList = detail?.skus ?? [];
    if (selectKey.isNotEmpty && skuList.isNotEmpty) {
      return skuList.singleWhere(
        (e) => e.skey == selectKey,
        orElse: () => Skus(id: 0),
      );
    }
    return Skus(id: 0);
  }

  String get selectSkuItemNames {
    List<String> names = [];

    detail?.specs?.forEach((e) {
      final item =
          e.specValues?.singleWhere((v) => selectSkuKeys.contains('${v.id}'));
      if (item != null) {
        names.add(item.value ?? '');
      }
    });

    return names.join(',');
  }

  void init() async {
    goodsId = Get.parameters['id'] ?? '';
    buyType = Get.parameters['buyType'] ?? '';
    if (goodsId.isNotEmpty) {
      fetchData();
    }
  }

  /// 跳转页面
  void navTo(String type, [Function()? cb]) {
    String routeName = '';

    if (['1', '2'].contains(type)) {
      routeName = '/pages/goods/purchase/index';
    } else if (type == '3') {
      routeName = '/pages/goods/ask-friend/index';
    }

    if (routeName.isNotEmpty) {
      final orderId = Get.parameters['orderId'] ?? '';
      final Map<String, String> parameters = {
        'id': goodsId,
        'buyType': type,
        'skuId': '${selectSku.id}',
        'orderId': orderId,
      };

      Get.toNamed(routeName, parameters: parameters)?.then((value) {
        cb?.call();
      });
    }
  }

  /// 页面跳转处理
  /// 跳转类型 [type]
  /// 0是点击赠送（需要选择赠送方式）, 1是赠送给自己，2是赠送给好友，3是拜托好友
  void navHandling(int type) {
    if (type == 0) {
      showGiftMethodModal();
    } else {
      buyType = '$type';
      if (detail!.skuType == 1) {
        showSkuModal();
      } else {
        navTo(buyType, showTips);
      }
    }
  }

  /// sku选择弹窗
  void showSkuModal() {
    final sku = detail?.skus?.singleWhere(
      (e) => e.isDefalut == 1,
      orElse: () => Skus(id: 0),
    );
    selectSkuKeys = sku?.skey?.split('-') ?? [];
    update(['SkuSelectView']);
    app.showBottomModal(
      context: Get.context!,
      builder: (context) {
        return SkuSelectView(
          onConfirm: () {
            navTo(buyType, showTips);
          },
        );
      },
    );
  }

  /// 赠送方式选择弹窗
  void showGiftMethodModal() {
    app.showBottomModal(
      context: Get.context!,
      builder: (context) {
        return GiftMethodSelectView(
          isBuy1Get1Free: detail?.buy1Get1FREE == 1,
          onTap: (type) {
            Get.back();
            navHandling(type);
          },
        );
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
    SmartDialog.showLoading(msg: '加載中...');
    try {
      final res = await GiftService.getGift(goodsId);
      final data = res.data ?? {};
      final isSuccess = data['isSuccess'];

      detail = GiftDetailVo.fromJson(data['data'] ?? {});

      if (isSuccess == true) {
        update([
          'GoodsDetailImages',
          'GoodsDetailBaseInfo',
          'GoodsDetailInfo',
          'ExchangeTerms'
        ]);

        if (buyType.isNotEmpty) {
          navHandling(int.tryParse(buyType) ?? 0);
        } else {
          showTips();
        }
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });
      }
    } catch (err) {
      logger.e(err);
    } finally {
      SmartDialog.dismiss();
    }
  }

  /// 切换图片
  void onImageChanged(int index) {
    currentImageIndex = index;
    update(['GoodsDetailImages']);
  }
}
