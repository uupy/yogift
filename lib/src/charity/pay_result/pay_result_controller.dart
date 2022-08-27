import 'package:get/get.dart';
import 'package:yo_gift/models/charity_favorites_item_detail.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/charity_favorites.dart';
import 'package:yo_gift/services/user_order.dart';

class CharityPayResultController extends GetxController {
  final orderId = Get.parameters['orderId'];
  OrderDetailItemVo? orderInfo;
  CharityFavoritesItemDetailVo? goodsInfo;

  /// 1 = 未支付， 2 = 已支付， 3 = 已取消
  int? payStatus;

  String get statusName {
    if (payStatus == 1) {
      return '未支付';
    } else if (payStatus == 2) {
      return '捐贈成功';
    }
    return '';
  }

  Future fetchData() async {
    await getPayStatus();
    await getOrderDetail();
    getGoodsDetail();
  }

  Future getPayStatus() async {
    final res = await UserOrderService.getPayResult(orderId!);
    final data = res.data ?? {};
    final info = data['data'] ?? {};

    payStatus = info['PayStatus'];

    update(['ResultCard']);
  }

  Future getOrderDetail() async {
    final res = await UserOrderService.getItem(orderId!);
    final data = res.data ?? {};

    orderInfo = OrderDetailItemVo.fromJson(data['data'] ?? {});

    update();
  }

  Future getGoodsDetail() async {
    final res = await CharityFavoritesService.getItem({
      'Id_Guid': orderInfo?.charityFavoritesGuid,
      'c_guid': orderInfo?.charityGuid,
    });
    final data = res.data ?? {};

    goodsInfo = CharityFavoritesItemDetailVo.fromJson(data['data'] ?? {});

    update();
  }
}
