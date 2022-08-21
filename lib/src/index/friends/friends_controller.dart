import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/friends_list.dart';
import 'package:yo_gift/services/friends_list.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class FriendsController extends GetxController {
  final listController = AppListController<FriendVo>();

  @override
  void onInit() {
    app.loginCallback = onReload;
    super.onInit();
  }

  Future onReload() async {
    listController.onReload();
  }

  Future<List<FriendVo>> queryList(Map<String, dynamic> params) async {
    final res = await FriendsListService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => FriendVo.fromJson(e)).toList();
  }
}
