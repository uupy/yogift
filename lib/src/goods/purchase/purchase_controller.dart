import 'dart:async';
import 'dart:io';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/user_order/add.dart';
import 'package:yo_gift/models/user_order/add_4_steps.dart';
import 'package:yo_gift/models/user_order/add_to_friend.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/models/user_order/receiving_address.dart';
import 'package:yo_gift/models/verification.dart';
import 'package:yo_gift/services/address_list.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/services/verification.dart';
import 'package:yo_gift/src/order/pay/pay_controller.dart';

class PurchaseController extends GetxController {
  int? skuId = int.tryParse(Get.parameters['skuId'] ?? '0');
  String goodsId = Get.parameters['id'] ?? '';

  /// 1 买给自己， 2 送给别人
  final buyType = Get.parameters['buyType'];

  /// 下单，买给自己（已登录状态）
  late final baseForm = AddVo();

  /// 下单，送给好友（已登录状态）
  final addToFriendForm = AddToFriendVo();

  /// 送给好友下单成功后，设置收礼人收货地址信息
  final receiverInfo = ReceivingAddressVo();

  /// 下单（未登录状态）
  late final add4StepsForm = Add4StepsVo(
    giftIdGuid: goodsId,
    acceptnotice: 0,
    introducer: '',
    logintype: 1,
    num: 1,
    regfrom: Platform.isAndroid ? '18' : '19',
  );

  String orderId = Get.parameters['orderId'] ?? '';
  String remark = '';
  String greetingCardId = '';
  String greetingCardMsg = '';

  /// 商品信息
  GiftDetailVo? detail;

  /// 下单成功信息
  OrderDetailItemVo? orderInfo;

  /// 下单步骤： 1 填写心愿卡，2 结账
  int currentStep = 1;

  List<AreaVo> areaList1 = [];
  List<AreaVo> areaList2 = [];

  /// 收礼人收货信息由谁填写：0 由收礼人填写， 1 由送礼人填写
  int receiverInfoMethod = 1;

  /// 用户是否已登录
  bool isLogged = false;

  /// 是否新用户
  bool isNewUser = true;

  /// 同意用户条款
  bool isAgreeTerms = true;

  /// 提交中
  bool submitting = false;

  /// 轮询间隔时间
  static const _timeout = Duration(seconds: 1);

  /// 定时器
  Timer? _timer;

  /// 发送验证码倒计时
  int countdown = 0;

  /// 是否捐贈訂單
  bool get isDonation {
    return orderInfo?.charityFavoritesGuid?.isNotEmpty ?? false;
  }

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
    goodsId = Get.parameters['id'] ?? '';
    orderId = Get.parameters['orderId'] ?? '';
    skuId = int.tryParse(Get.parameters['skuId'] ?? '0');

    update(['SenderInfo']);

    fetchData();
  }

  /// 获取礼物详情
  Future fetchData() async {
    try {
      SmartDialog.showLoading(msg: '加載中...');
      final res = await GiftService.getGift(goodsId);
      final data = res.data ?? {};
      detail = GiftDetailVo.fromJson(data['data'] ?? {});

      if (skuId != null && skuId != 0) {
        final sku = detail?.skus?.firstWhereOrNull((e) => e.id == skuId);
        if (sku != null) {
          detail!.buyPrice = (sku.buyPrice ?? 0).toDouble();
        }
      }

      if (orderId.isNotEmpty) {
        final res1 = await UserOrderService.getItem(orderId);
        final data1 = res1.data ?? {};
        orderInfo = OrderDetailItemVo.fromJson(data1['data'] ?? {});
        detail!.buyPrice = orderInfo!.buyPrice;
      }

      // add4StepsForm.money = (detail?.buyPrice ?? 0).toDouble();
      update(['AppBarTitle', 'DetailInfo', 'ReceiverInfo', 'PurchaseFooter']);
      if (buyType == '2') {
        queryAreaList(0);
      }
    } finally {
      SmartDialog.dismiss();
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

  /// 提交下单
  Future onSubmit() async {
    logger.i(orderId);
    if (submitting) return;
    if (orderId.isNotEmpty) {
      onPay();
    } else {
      if (isLogged) {
        if (isGiveToSelf) {
          await onAddToSelf();
        } else {
          await onAddToFriend();
        }
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
    add4StepsForm.content2 = remark;
    add4StepsForm.receivingaddressArea0Id =
        receiverInfo.receivingaddressArea0Id ?? 0;
    add4StepsForm.receivingaddressArea1Id =
        receiverInfo.receivingaddressArea1Id ?? 0;

    submitting = true;
    update(['PurchaseFooter']);
    try {
      final res = await UserOrderService.add4Steps(add4StepsForm);
      final data = res.data['data'] ?? {};
      final info = data['Order'] ?? {};
      await app.updateAuthData(data);
      await app.updateUserInfo();

      isLogged = true;
      orderInfo = OrderDetailItemVo.fromJson(info);
      orderId = orderInfo!.oGuid ?? '';

      if (!isGiveToSelf && receiverInfoMethod == 1) {
        receiverInfo.idGuid = orderId;
        await UserOrderService.setReceivingaddress(receiverInfo);
      }

      onPay();
    } finally {
      submitting = false;
      update(['PurchaseFooter']);
    }
  }

  /// 登錄狀態，買給自己
  Future onAddToSelf() async {
    baseForm.giftIdGuid = goodsId;
    baseForm.skuid = skuId;
    baseForm.num = 1;
    baseForm.money = detail?.buyPrice ?? 0;
    baseForm.content2 = remark;

    submitting = true;
    update(['PurchaseFooter']);
    try {
      final res = await UserOrderService.add(baseForm);
      final data = res.data ?? {};

      onPay(data);
    } finally {
      submitting = false;
      update(['PurchaseFooter']);
    }
  }

  /// 登錄狀態，贈送好友
  Future onAddToFriend() async {
    addToFriendForm.giftIdGuid = goodsId;
    addToFriendForm.skuid = skuId;
    addToFriendForm.num = 1;
    addToFriendForm.money = detail?.buyPrice ?? 0;
    addToFriendForm.content2 = remark;
    addToFriendForm.bgGive = greetingCardId;
    addToFriendForm.msgGive = greetingCardMsg;

    submitting = true;
    update(['PurchaseFooter']);
    try {
      final res = await UserOrderService.addToFriend(addToFriendForm);
      final data = res.data ?? {};

      onPay(data);
    } finally {
      submitting = false;
      update(['PurchaseFooter']);
    }
  }

  Future onPay([Map<String, dynamic>? data]) async {
    if (data != null) {
      final info = data['data'] ?? {};
      final isSuccess = data['isSuccess'] ?? false;
      final code = data['code'];

      orderInfo = OrderDetailItemVo.fromJson(info);
      orderId = orderInfo!.oGuid ?? '';

      if (isSuccess == false) {
        if (code == 30001) {
          Future.delayed(const Duration(seconds: 1), () {
            final Map<String, String> parameters = {
              'id': goodsId,
              'skuId': '${orderInfo!.skuId ?? 0}',
            };

            parameters['orderId'] = orderInfo!.oGuid ?? '';
            parameters['buyType'] = '1';

            logger.i(parameters);

            Get.offNamedUntil(
              '/pages/goods/purchase/index',
              (route) => route.isFirst,
              parameters: parameters,
            );
          });
        }
        return;
      }
    }
    if (orderId.isNotEmpty) {
      final payController = Get.put(PayController());
      await payController.showModal(orderId);
    } else {
      app.showToast('訂單id不能為空');
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
