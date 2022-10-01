import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/greeting_card.dart';
import 'package:yo_gift/services/greeting_card.dart';

class GreetingCardController extends GetxController {
  final msgController = TextEditingController();
  List<GreetingCardVo> cards = [];
  GreetingCardVo? currentCard;
  String cardMsg = '';
  Function(String cardId, String msg, String image)? onChanged;

  /// 是否编辑卡片信息
  bool isEditMsg = false;

  /// 切换心愿卡片
  void switchCard(GreetingCardVo card) {
    if (card.content1?.isNotEmpty ?? false) {
      cardMsg = card.content1!.first;
    } else {
      cardMsg = '';
    }
    msgController.text = cardMsg;
    currentCard = card;
    onCardChanged();
    update(['GreetingCardList', 'GreetingCardSelect']);
  }

  /// 获取礼物详情
  /// [type] 类型, 0全部，1拜托专用，2非拜托卡
  Future queryCards(int type) async {
    final res = await GreetingCardService.queryPage({
      'pageindex': 1,
      'pagesize': 100,
      'Type1': type,
    });
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    cards = items.map((e) => GreetingCardVo.fromJson(e)).toList();
    if (cards.isNotEmpty) {
      switchCard(cards.first);
    }
    update(['GreetingCard']);
  }

  void onCardChanged() {
    onChanged?.call(currentCard!.gCGuid!, cardMsg, currentCard!.bigImg ?? '');
  }
}
