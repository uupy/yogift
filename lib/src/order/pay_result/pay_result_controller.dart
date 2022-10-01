import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/services/user_order.dart';
import 'package:yo_gift/widgets/share/share_modal.dart';

class PayResultController extends GetxController {
  final orderId = Get.parameters['orderId'];
  OrderDetailItemVo? orderInfo;

  /// 1 = 未支付， 2 = 已支付， 3 = 已取消
  int? payStatus;

  String get statusName {
    if (payStatus == 1) {
      return '未支付';
    } else if (payStatus == 2) {
      return '付款成功';
    }
    return '';
  }

  Future fetchData() async {
    final res = await UserOrderService.getPayResult(orderId!);
    final data = res.data ?? {};
    final info = data['data'] ?? {};

    payStatus = info['PayStatus'];

    update(['ResultCard']);
    fetchOrderData();
  }

  Future fetchOrderData() async {
    final res = await UserOrderService.getItem(orderId!);
    final data = res.data ?? {};

    orderInfo = OrderDetailItemVo.fromJson(data['data'] ?? {});
    showShareModal();
  }

  Future showShareModal() async {
    ShareModal.show(
      title: '你想如何贈送好友？',
      type: 0,
      id: orderId!,
      goodsName: orderInfo!.giftName ?? '',
      goodsImageUrl: orderInfo!.cCoverImg,
    );
  }

  Future<List<GiftVo>> queryList(params) async {
    final res = await GiftService.queryListExplore(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => GiftVo.fromJson(e)).toList();
  }
}
