import 'package:get/get.dart';
import 'package:yo_gift/models/coupon_item.dart';
import 'package:yo_gift/services/user_coupon.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class CouponController extends GetxController {
  final listController = AppListController<CouponItem>();
  List items = [];
  int status = 1;

  Future<List<CouponItem>> queryList(params) async {
    final res = await UserCoupon.queryUserCouponList({
      ...params,
      ...{'status': status}
    });
    final data = res.data ?? {};
    items = data['data'] ?? [];
    return items.map((e) => CouponItem.fromJson(e)).toList();
  }

  Future onReload() async {
    listController.onReload();
  }

  Future updateList(s) async {
    status = s;
    listController.onReload();
  }
}
