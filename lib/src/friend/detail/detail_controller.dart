import 'package:get/get.dart';
import 'package:yo_gift/models/friends_list.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/friends_list.dart';
import 'package:yo_gift/services/user.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class FriendDetailController extends GetxController {
  final friendId = Get.parameters['friendId'];
  final friendName = Get.parameters['friendName'];
  final listController = AppListController<FriendMsgVo>();
  UserInfoVo? user;

  Future init() async {
    final res = await UserService.getInfo();
    final data = res.data ?? {};
    user = UserInfoVo.fromJson(data['data'] ?? {});
    update();
  }

  Future onReload() async {
    listController.onReload();
  }

  Future<List<FriendMsgVo>> queryList(Map<String, dynamic> params) async {
    params['friend_id'] = friendId;
    params['pagesize'] = 99;
    final res = await FriendsListService.queryMsgPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => FriendMsgVo.fromJson(e)).toList();
  }
}
