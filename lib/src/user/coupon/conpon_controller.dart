import 'package:get/get.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/models/coupon_item.dart';
import 'package:yo_gift/services/user_coupon.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class CouponController extends GetxController {
  final listController = AppListController<CouponItem>();

  Future<List<CouponItem>> queryList(params) async {
    final res = await UserCoupon.queryUserCouponList(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => CouponItem.fromJson(e)).toList();
  }

  Future onReload() async {
    listController.onReload();
  }
}
