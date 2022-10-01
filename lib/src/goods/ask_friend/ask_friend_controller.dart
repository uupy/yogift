import 'dart:async';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/gift_request.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/gift_request.dart';
import 'package:yo_gift/widgets/share/share_modal.dart';

class AskFriendController extends GetxController {
  final goodsId = Get.parameters['id'];
  final skuId = int.tryParse(Get.parameters['skuId'] ?? '');
  late final baseForm = GiftRequestAddVo(
    gGuid: goodsId,
    skuid: skuId,
    content2: '',
    gCGuid: '',
    msgRequest: '',
  );

  /// 商品信息
  GiftDetailVo? detail;

  /// 下单成功信息
  GiftRequestResultVo? orderInfo;

  String cardImageUrl = '';

  /// 用户是否已登录
  bool isLogged = false;

  /// 提交中
  bool submitting = false;

  void init() async {
    final _token = await accessToken.get() ?? '';

    isLogged = _token.isNotEmpty;

    if (!isLogged) {
      goLogin();
    }

    fetchData();
  }

  void goLogin() {
    app.showToast('請先登入');
    Get.toNamed('/login')?.then((value) {
      isLogged = value == true;
    });
  }

  /// 获取礼物详情
  Future fetchData() async {
    try {
      SmartDialog.showLoading(msg: '加載中...');
      final res = await GiftService.getGift(goodsId!);
      final data = res.data ?? {};
      detail = GiftDetailVo.fromJson(data['data'] ?? {});

      if (skuId != null && skuId != 0) {
        final sku = detail?.skus?.firstWhereOrNull((e) => e.id == skuId);
        if (sku != null) {
          detail!.buyPrice = (sku.buyPrice ?? 0).toDouble();
        }
      }
      update(['DetailInfo']);
    } finally {
      SmartDialog.dismiss();
    }
  }

  /// 提交下单
  Future onSubmit() async {
    if (orderInfo != null) {
      onCreateSuccess();
    } else {
      if (isLogged) {
        try {
          submitting = true;
          update();
          final res = await GiftRequestService.add(baseForm);
          final data = res.data['data'] ?? {};
          orderInfo = GiftRequestResultVo.fromJson(data);
          onCreateSuccess();
        } finally {
          submitting = false;
          update();
        }
      } else {
        goLogin();
      }
    }
  }

  /// 下單成功
  Future onCreateSuccess() async {
    await ShareModal.show(
      title: '你想如何拜託好友？',
      type: 3,
      id: orderInfo!.gGuid ?? '',
      goodsName: orderInfo!.giftName ?? '',
      goodsImageUrl: orderInfo!.cCoverImg,
      cardImageUrl: cardImageUrl,
      cardMsg: baseForm.msgRequest,
    );
  }
}
