import 'package:get/get.dart';
import 'package:yo_gift/models/user_favorites.dart';
import 'package:yo_gift/services/user_favorites.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class UserWishController extends GetxController {
  final listController = AppListController<UserFavoritesItemVo>();

  Future<List<UserFavoritesItemVo>> queryList(
      Map<String, dynamic> params) async {
    final res = await UserFavoritesService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => UserFavoritesItemVo.fromJson(e)).toList();
  }
}
