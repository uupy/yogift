import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/gift_coupon_item.dart';
import 'package:yo_gift/services/user_coupon.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class GiftCouponController extends GetxController {
  final listController = AppListController<GiftCouponItem>();

  int state = 1;
  List items = [];
  final arguments = Get.arguments;
  int availiableCount = 0;
  int disbleCount = 0;

  Future<List<GiftCouponItem>> queryGiftCouponList(params) async {
    try {
      items = [];
      final res = await UserCoupon.queryGiftCouponList({
        ...params,
        ...{'state': state},
        ...arguments
      });
      final data = res.data ?? {};
      items = data['data'] ?? [];
      return items.map((e) => GiftCouponItem.fromJson(e)).toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  void onInit() async {
    availiableCount = await queryCouponCount(1);
    disbleCount = await queryCouponCount(0);
    update();
    super.onInit();
  }

  Future onReload() async {
    listController.onReload();
  }

  Future queryCouponCount(s) async {
    try {
      final res = await UserCoupon.queryGiftCouponList({
        ...{'state': s},
        ...arguments
      });
      final data = res.data ?? {};
      return data['rowCount'];
    } catch (e) {
      logger.e(e);
      return 0;
    }
  }

  Future updateGiftCouponList(s) async {
    state = s == 0 ? 1 : 0;
    listController.onReload();
  }
}
