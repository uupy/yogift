import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/greeting_card.dart';
import 'package:yo_gift/models/user_order.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/greeting_card.dart';

class PurchaseController extends GetxController {
  final formData = UserOrderFormVo();
  final goodsId = Get.parameters['id'];
  final msgController = TextEditingController();
  GiftDetailVo? detail;
  int currentStep = 1;
  List<GreetingCardVo> cards = [];
  GreetingCardVo? currentCard;
  bool isEditMsg = false;

  void init() {
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

  void switchCard(GreetingCardVo? card) {
    currentCard = card;
    if (currentCard!.content1?.isNotEmpty ?? false) {
      formData.msgGive = currentCard!.content1!.first;
      msgController.text = formData.msgGive ?? '';
    }
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
}
