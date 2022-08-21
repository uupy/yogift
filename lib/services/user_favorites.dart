import 'package:yo_gift/common/http.dart';

class UserFavoritesService {
  UserFavoritesService._();

  /// 清单
  /// 页码 [pageindex] 必须
  /// 每页条数 [pagesize] 必须
  static Future queryPage(data) =>
      http.postJson('/UserFavorites/List', data: data);

  /// 清单(某好友)
  /// 好友id [friend_userid] 必须
  /// 页码 [pageindex] 必须
  /// 每页条数 [pagesize] 必须
  static Future queryPageForFriend(data) =>
      http.postJson('/UserFavorites/List_For_Friend', data: data);

  /// 添加或删除双操作
  static Future addOrDelete(String goodsId) =>
      http.postJson('/UserFavorites/Add_Or_Delete', data: {
        'id_guid': goodsId,
      });
}
