import 'package:yo_gift/common/http.dart';

/// 好友接口服务
class FriendsListService {
  FriendsListService._();

  /// 清单
  static Future queryPage(data) =>
      http.postJson('/FriendsList/List', data: data);

  /// 成功邀请的人
  static Future queryIntroducerPage(data) =>
      http.postJson('/FriendsList/Introducer_List', data: data);

  /// 好友间消息列表
  static Future queryMsgPage(data) =>
      http.postJson('/FriendsList/List_msg', data: data);
}
