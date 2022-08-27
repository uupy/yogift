import 'dart:async';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/gift_request.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/gift_request.dart';

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

  /// 用户是否已登录
  bool isLogged = false;

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
    final res = await GiftService.getGift(goodsId!);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    update(['DetailInfo']);
  }

  /// 提交下单
  Future onSubmit() async {
    if (orderInfo != null) {
      onCreateSuccess();
    } else {
      if (isLogged) {
        final res = await GiftRequestService.add(baseForm);
        final data = res.data['data'] ?? {};
        orderInfo = GiftRequestResultVo.fromJson(data);
        onCreateSuccess();
      } else {
        goLogin();
      }
    }
  }

  /// 下單成功
  Future onCreateSuccess() async {
    await Share.share(
      'bbb',
      subject: 'aaa',
    );
  }
}
