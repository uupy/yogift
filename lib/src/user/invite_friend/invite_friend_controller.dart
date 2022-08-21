import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/models/friends_list.dart';
import 'package:yo_gift/models/user.dart';
import 'package:yo_gift/services/friends_list.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class InviteFriendController extends GetxController {
  final listController = AppListController<IntroducerVo>();
  UserInfoVo? userInfo;
  SetupConfig? config;

  String get inviteUrl {
    final userId = userInfo?.id ?? '';
    final url = config?.recommendationCodeUrl?.value ?? '';

    if (userId.isNotEmpty && url.isNotEmpty) {
      return url.replaceFirst('rc={code}', 'userId=$userId');
    }
    return '';
  }

  @override
  void onInit() {
    fetchData();
    app.loginCallback = fetchData;
    super.onInit();
  }

  Future fetchData() async {
    final info = await loginUser.get() ?? {};
    final appController = Get.find<AppController>();
    config = appController.config?.setupConfig;
    userInfo = UserInfoVo.fromJson(info);
    listController.onReload();
    update(['InviteHeader']);
  }

  Future<List<IntroducerVo>> queryList(Map<String, dynamic> params) async {
    final res = await FriendsListService.queryIntroducerPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => IntroducerVo.fromJson(e)).toList();
  }
}
