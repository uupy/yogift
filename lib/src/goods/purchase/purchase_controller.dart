import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/greeting_card.dart';
import 'package:yo_gift/models/user_order.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/greeting_card.dart';
import 'package:yo_gift/services/verification.dart';

class PurchaseController extends GetxController {
  final goodsId = Get.parameters['id'];
  final msgController = TextEditingController();
  late final formData = UserOrderFormVo(
    giftIdGuid: goodsId,
    acceptnotice: 0,
    receivingaddressArea0Id: 0,
    receivingaddressArea1Id: 0,
    receivingaddressAddress: '',
    receivingaddressContact: '',
    receivingaddressPhone: '',
    introducer: '',
    logintype: 1,
    num: 1,
    regfrom: '2',
  );
  GiftDetailVo? detail;
  int currentStep = 1;
  List<GreetingCardVo> cards = [];
  GreetingCardVo? currentCard;
  bool isEditMsg = false;
  bool isNewUser = true;
  bool isAgreeTerms = true;

  /// 轮询间隔时间
  static const _timeout = Duration(seconds: 1);

  /// 定时器
  Timer? _timer;

  /// 发送验证码倒计时
  int countdown = 0;

  bool get phoneNotEmpty {
    final prefixNotEmpty = formData.phoneprefix?.isNotEmpty ?? false;
    final phoneNotEmpty = formData.phone?.isNotEmpty ?? false;
    return prefixNotEmpty && phoneNotEmpty;
  }

  bool get getCodeAble {
    return phoneNotEmpty && countdown <= 0;
  }

  void init() {
    fetchData();
    queryCards();
  }

  /// 获取礼物详情
  Future fetchData() async {
    final res = await GiftService.getGift(goodsId!);
    final data = res.data ?? {};
    detail = GiftDetailVo.fromJson(data['data'] ?? {});
    formData.money = (detail?.buyPrice ?? 0).toDouble();
    update(['DetailInfo']);
  }

  void switchCard(GreetingCardVo? card) {
    currentCard = card;
    if (currentCard!.content1?.isNotEmpty ?? false) {
      formData.msgGive = currentCard!.content1!.first;
      msgController.text = formData.msgGive ?? '';
    }
    formData.bgGive = card?.gCGuid;
    update(['GreetingCard']);
  }

  /// 获取礼物详情
  Future queryCards() async {
    final res = await GreetingCardService.queryPage({
      'pageindex': 1,
      'pagesize': 100,
      'Type1': 2,
    });
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    cards = items.map((e) => GreetingCardVo.fromJson(e)).toList();
    if (cards.isNotEmpty) {
      switchCard(cards.first);
    }
    update(['GreetingCard']);
  }

  Future getCode() async {
    final data = SendDataVo(
      phone: formData.phone,
      prefix: formData.phoneprefix,
    );
    await VerificationService.getCodeForRegister(data);
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
