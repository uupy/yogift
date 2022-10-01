import 'dart:async';

import 'package:get/get.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/models/gift_detail.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/models/user_order/receiving_address.dart';
import 'package:yo_gift/services/address_list.dart';
import 'package:yo_gift/services/give.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/widgets/share/share_modal.dart';

class OrderGiveFriendController extends GetxController {
  final orderId = Get.parameters['orderId'];

  /// 送给好友下单成功后，设置收礼人收货地址信息
  final receiverInfo = ReceivingAddressVo();

  String greetingCardId = '';
  String greetingCardMsg = '';
  bool hasSuccess = false;
  bool submitting = false;

  /// 商品信息
  GiftDetailVo? detail;

  /// 下单成功信息
  OrderDetailItemVo? orderInfo;

  List<AreaVo> areaList1 = [];
  List<AreaVo> areaList2 = [];

  /// 收礼人收货信息由谁填写：0 由收礼人填写， 1 由送礼人填写
  int receiverInfoMethod = 1;

  bool get needAddressInfo {
    return detail?.sendingMethod == 2 && receiverInfoMethod == 1;
  }

  /// 是否需要滚动到收礼人资料位置
  bool get receiverInfoNotPerfection {
    if (needAddressInfo) {
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
    fetchData();
  }

  /// 获取礼物详情
  Future fetchData() async {
    final res = await UserOrderService.getItem(orderId!);
    final data = res.data ?? {};
    final json = data['data'] ?? {};
    detail = GiftDetailVo.fromJson(json);
    orderInfo = OrderDetailItemVo.fromJson(json);
    update(['DetailInfo', 'ReceiverInfo', 'OrderGiveFriendFooter']);
    queryAreaList(0);
  }

  Future queryAreaList(int? parentId) async {
    if (parentId != null) {
      final res = await AddressListService.queryList(parentId);
      final data = res.data ?? {};
      final List items = data['data'] ?? [];

      if (parentId == 0) {
        areaList1 = items.map((e) => AreaVo.fromJson(e)).toList();
      } else {
        receiverInfo.receivingaddressArea1Id = null;
        areaList2 = items.map((e) => AreaVo.fromJson(e)).toList();
      }
    } else {
      receiverInfo.receivingaddressArea1Id = null;
      areaList2.clear();
    }
    update(['ReceiverInfo']);
  }

  /// 提交下单
  Future onSubmit() async {
    if (hasSuccess) {
      onCreateSuccess();
    } else {
      await onAddToFriend();
    }
  }

  /// 登錄狀態，贈送好友
  Future onAddToFriend() async {
    submitting = true;
    update(['OrderGiveFriendFooter']);
    try {
      if (needAddressInfo) {
        receiverInfo.idGuid = orderId;
        await UserOrderService.setReceivingaddress(receiverInfo);
      }
      await GiveService.addOrEdit({
        'order_id_guid': orderId,
        'msg_give': greetingCardMsg,
        'bg_give': greetingCardId,
      });
      hasSuccess = true;
      onCreateSuccess();
    } finally {
      submitting = false;
      update(['OrderGiveFriendFooter']);
    }
  }

  /// 下單成功
  Future onCreateSuccess() async {
    await ShareModal.show(
      title: '你想如何贈送好友？',
      type: 0,
      id: orderId!,
      goodsName: detail?.giftName ?? '',
    );
  }
}
