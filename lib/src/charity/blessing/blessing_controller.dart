import 'dart:async';

import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/charity_favorites_item_detail.dart';
import 'package:yo_gift/models/user_order/add.dart';
import 'package:yo_gift/models/user_order/add_for_charity_favorite.dart';
import 'package:yo_gift/models/user_order/order_detail_item.dart';
import 'package:yo_gift/services/charity_favorites.dart';
import 'package:yo_gift/services/user_order.dart';

class CharityBlessingController extends GetxController {
  final orgId = Get.parameters['orgId'];
  final wishId = Get.parameters['wishId'];
  final baseForm = AddVo();
  final addForm = AddForCharityFavoriteVo(
    quantity: 1,
  );
  String remark = '';
  int currentStep = 1;

  /// 商品信息
  CharityFavoritesItemDetailVo? detail;

  /// 下单成功信息
  OrderDetailItemVo? orderInfo;

  /// 用户是否已登录
  bool isLogged = false;

  num get totalPrice {
    final price = detail?.buyPriceForCharity ?? 0;
    final n = addForm.quantity ?? 1;
    return price * n;
  }

  void init() async {
    final _token = await accessToken.get() ?? '';
    isLogged = _token.isNotEmpty;
    fetchData();
  }

  /// 获取礼物详情
  Future fetchData() async {
    final res = await CharityFavoritesService.getItem({
      'Id_Guid': wishId,
      'c_guid': orgId,
    });
    final data = res.data ?? {};
    detail = CharityFavoritesItemDetailVo.fromJson(data['data'] ?? {});
    update(['DetailInfo', 'BlessingFooter']);
  }

  /// 提交下单
  Future onSubmit() async {
    if (isLogged) {
      await onCreateOrder();
    } else {
      app.showToast('請先登入');
      Get.toNamed('/login')?.then((value) {
        isLogged = value == true;
      });
    }
  }

  /// 登錄狀態，贈送好友
  Future onCreateOrder() async {
    addForm.charityfavoritesIdGuid = wishId;
    addForm.money = totalPrice;
    addForm.content2 = remark;
    addForm.skuid = 0;
    addForm.ygcoupon1id = 0;

    final res = await UserOrderService.addForCharityFavorite(addForm);
    final code = res.data['code'];
    final isSuccess = res.data['isSuccess'];
    final data = res.data['data'] ?? {};

    if (isSuccess || code == 30001) {
      orderInfo = OrderDetailItemVo.fromJson(data);
      if (code == 30001) {
        await Future.delayed(const Duration(seconds: 1));
      }
      Get.offNamed('/pages/charity/pay/index', parameters: {
        'orderId': orderInfo!.oGuid!,
      });
    }
  }
}
