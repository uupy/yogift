import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/greeting_card.dart';
import 'package:yo_gift/models/user_order/add.dart';
import 'package:yo_gift/models/user_order/add_4_steps.dart';
import 'package:yo_gift/models/user_order/add_for_request.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/greeting_card.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/services/verification.dart';
import 'package:yo_gift/src/order/pay/pay_controller.dart';

class BlessingController extends GetxController {
  final goodsId = Get.parameters['id'];
  final skuId = int.tryParse(Get.parameters['skuId'] ?? '');

  /// 1 买给自己， 2 送给别人
  final buyType = Get.parameters['buyType'];
  final msgController = TextEditingController();

  final baseForm = AddVo();

  final addToFriendForm = AddForRequestVo();

  /// 下单（未登录状态）
  late final add4StepsForm = Add4StepsVo(
    giftIdGuid: goodsId,
    acceptnotice: 0,
    introducer: '',
    logintype: 1,
    num: 1,
    regfrom: '2',
  );

  /// 商品信息
  GiftDetailVo? detail;

  /// 下单成功信息
  OrderDetailItemVo? orderInfo;

  List<GreetingCardVo> cards = [];
  GreetingCardVo? currentCard;

  /// 用户是否已登录
  bool isLogged = false;

  /// 是否编辑卡片信息
  bool isEditMsg = false;

  /// 是否新用户
  bool isNewUser = true;

  /// 同意用户条款
  bool isAgreeTerms = true;

  /// 轮询间隔时间
  static const _timeout = Duration(seconds: 1);

  /// 定时器
  Timer? _timer;

  /// 发送验证码倒计时
  int countdown = 0;

  bool get phoneNotEmpty {
    final prefixNotEmpty = add4StepsForm.phoneprefix?.isNotEmpty ?? false;
    final phoneNotEmpty = add4StepsForm.phone?.isNotEmpty ?? false;
    return prefixNotEmpty && phoneNotEmpty;
  }

  bool get getCodeAble {
    return phoneNotEmpty && countdown <= 0;
  }

  /// 是否需要滚动到送礼人资料位置
  bool get senderInfoNotPerfection {
    if (!isLogged) {
      final codeEmpty = add4StepsForm.codePassword?.isEmpty ?? true;
      return !phoneNotEmpty || codeEmpty || !isAgreeTerms;
    }
    return false;
  }

  void init() async {
    final _token = await accessToken.get() ?? '';

    isLogged = _token.isNotEmpty;

    update(['SenderInfo']);

    fetchData();
    queryCards();
  }

  /// 获取礼物详情
  Future fetchData() async {
    final res = await GiftService.getGift(goodsId!);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    update(['DetailInfo']);
  }

  /// 切换心愿卡片
  void switchCard(GreetingCardVo? card) {
    currentCard = card;
    if (currentCard!.content1?.isNotEmpty ?? false) {
      final msg = currentCard!.content1!.first;
      add4StepsForm.msgGive = msg;
      addToFriendForm.msgGive = msg;
      msgController.text = msg;
    }
    add4StepsForm.bgGive = card?.gCGuid;
    addToFriendForm.bgGive = card?.gCGuid;
    update(['GreetingCard']);
  }

  /// 获取礼物详情
  Future queryCards() async {
    if (!isLogged) return;
    final res = await GreetingCardService.queryPage({
      'pageindex': 1,
      'pagesize': 100,
      'Type1': 1,
    });
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    cards = items.map((e) => GreetingCardVo.fromJson(e)).toList();
    if (cards.isNotEmpty) {
      switchCard(cards.first);
    }
    update(['GreetingCard']);
  }

  /// 提交下单
  Future onSubmit() async {
    if (orderInfo != null) {
      onPay();
    } else {
      if (isLogged) {
        await onAddToFriend();
      } else {
        onAdd4Steps();
      }
    }
  }

  /// 未登錄狀態
  Future onAdd4Steps() async {
    add4StepsForm.giftIdGuid = goodsId;
    add4StepsForm.skuid = skuId;
    add4StepsForm.num = 1;
    add4StepsForm.money = detail?.buyPrice ?? 0;
    add4StepsForm.content2 = baseForm.content2 ?? '';
    add4StepsForm.receivingaddressArea0Id = 0;
    add4StepsForm.receivingaddressArea1Id = 0;

    final res = await UserOrderService.add4Steps(add4StepsForm);
    final data = res.data['data'] ?? {};
    final info = data['Order'] ?? {};
    await app.updateAuthData(data);
    await app.updateUserInfo();
    orderInfo = OrderDetailItemVo.fromJson(info);
    onPay();
  }

  /// 登錄狀態，贈送好友
  Future onAddToFriend() async {
    addToFriendForm.requestGuid = goodsId;
    addToFriendForm.money = detail?.buyPrice ?? 0;
    addToFriendForm.content2 = baseForm.content2 ?? '';

    final res = await UserOrderService.addForRequest(addToFriendForm);
    final data = res.data['data'] ?? {};

    orderInfo = OrderDetailItemVo.fromJson(data);
    onPay();
  }

  Future onPay() async {
    if (orderInfo != null) {
      final payController = Get.put(PayController());
      await payController.showModal(orderInfo!.oGuid!);
    }
  }

  /// 获取短信验证码
  Future getCode() async {
    final data = SendDataVo(
      phone: add4StepsForm.phone,
      prefix: add4StepsForm.phoneprefix,
    );
    if (isNewUser) {
      await VerificationService.getCodeForRegister(data);
    } else {
      await VerificationService.getCodeForLogin(data);
    }

    runTimer();
  }

  /// 开启定时器
  void runTimer() {
    stopTimer();
    countdown = 60;
    update(['SenderInfo']);
    _timer = Timer.periodic(_timeout, (timer) {
      countdown--;
      if (countdown <= 0) {
        stopTimer();
      }
      update(['SenderInfo']);
    });
  }

  /// 关闭定时器
  void stopTimer() async {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
