import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/greeting_card.dart';
import 'package:yo_gift/models/user_order/add.dart';
import 'package:yo_gift/models/user_order/add_4_steps.dart';
import 'package:yo_gift/models/user_order/add_to_friend.dart';
import 'package:yo_gift/models/user_order/receiving_address.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/address_list.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/greeting_card.dart';
import 'package:yo_gift/services/verification.dart';

class PurchaseController extends GetxController {
  final goodsId = Get.parameters['id'];

  /// 1 买给自己， 2 送给别人
  final buyType = Get.parameters['buyType'];
  final msgController = TextEditingController();

  /// 下单，买给自己（已登录状态）
  final addForm = AddVo();

  /// 下单，送给好友（已登录状态）
  final addToFriendForm = AddToFriendVo();

  /// 送给好友下单成功后，设置收礼人收货地址信息
  final receiverInfo = ReceivingAddressVo();

  /// 下单（未登录状态）
  late final add4StepsForm = Add4StepsVo(
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

  /// 商品信息
  GiftDetailVo? detail;

  /// 下单步骤： 1 填写心愿卡，2 结账
  int currentStep = 1;
  List<GreetingCardVo> cards = [];
  GreetingCardVo? currentCard;

  List<AreaVo> areaList1 = [];
  List<AreaVo> areaList2 = [];

  /// 收礼人收货信息由谁填写：0 由收礼人填写， 1 由送礼人填写
  int receiverInfoMethod = 1;

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

  bool get isGiveToSelf {
    return buyType == '1';
  }

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

  /// 是否需要滚动到收礼人资料位置
  bool get receiverInfoNotPerfection {
    if (!isGiveToSelf &&
        detail?.sendingMethod == 2 &&
        receiverInfoMethod == 1) {
      final nameEmpty = receiverInfo.receivingaddressContact?.isEmpty ?? true;
      final phoneEmpty = receiverInfo.receivingaddressPhone?.isEmpty ?? true;
      final addressEmpty =
          receiverInfo.receivingaddressAddress?.isEmpty ?? true;
      final area0Empty = receiverInfo.receivingaddressArea0Id == null;
      final area1Empty = receiverInfo.receivingaddressArea0Id == null;
      return nameEmpty ||
          phoneEmpty ||
          addressEmpty ||
          area0Empty ||
          area1Empty;
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
    add4StepsForm.money = (detail?.buyPrice ?? 0).toDouble();
    update(['DetailInfo', 'ReceiverInfo']);
    if (buyType == '2') {
      queryAreaList(0);
    }
  }

  Future queryAreaList(int? parentId) async {
    if (parentId != null) {
      final res = await AddressListService.queryList(parentId);
      final data = res.data ?? {};
      final List items = data['data'] ?? [];

      if (parentId == 0) {
        areaList1 = items.map((e) => AreaVo.fromJson(e)).toList();
      } else {
        add4StepsForm.receivingaddressArea1Id = null;
        receiverInfo.receivingaddressArea1Id = null;
        areaList2 = items.map((e) => AreaVo.fromJson(e)).toList();
      }
    } else {
      add4StepsForm.receivingaddressArea1Id = null;
      receiverInfo.receivingaddressArea1Id = null;
      areaList2.clear();
    }
    update(['ReceiverInfo']);
  }

  /// 切换心愿卡片
  void switchCard(GreetingCardVo? card) {
    currentCard = card;
    if (currentCard!.content1?.isNotEmpty ?? false) {
      add4StepsForm.msgGive = currentCard!.content1!.first;
      msgController.text = add4StepsForm.msgGive ?? '';
    }
    add4StepsForm.bgGive = card?.gCGuid;
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

  /// 提交下单
  Future onSubmit() async {}

  /// 获取短信验证码
  Future getCode() async {
    final data = SendDataVo(
      phone: add4StepsForm.phone,
      prefix: add4StepsForm.phoneprefix,
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
