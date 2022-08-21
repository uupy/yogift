import 'package:get/get.dart';
import 'package:yo_gift/models/user_favorites.dart';
import 'package:yo_gift/services/user_favorites.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class UserWishController extends GetxController {
  final friendId = Get.parameters['friendId'] ?? '';
  final friendName = Get.parameters['friendName'];
  final listController = AppListController<UserFavoritesItemVo>();

  bool get isFriend {
    return friendId.isNotEmpty;
  }

  Future<List<UserFavoritesItemVo>> queryList(params) async {
    dynamic res;
    if (friendId.isNotEmpty) {
      params['friend_userid'] = friendId;
      res = await UserFavoritesService.queryPageForFriend(params);
    } else {
      res = await UserFavoritesService.queryPage(params);
    }
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => UserFavoritesItemVo.fromJson(e)).toList();
  }
}
