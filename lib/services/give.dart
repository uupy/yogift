import 'package:yo_gift/common/http.dart';

/// 礼物接口服务
class GiveService {
  GiveService._();

  /// 贈送清单
  static Future queryPage(data) => http.postJson('/Give/List_Give', data: data);

  /// 受赠清单,收到的礼物
  static Future queryAcceptPage(data) =>
      http.postJson('/Give/List_Accept', data: data);

  /// 添加或修改
  static Future addOrEdit(data) => http.postJson('/Give/Add_Edit', data: data);

  /// 接受某个贈送
  static Future accept(String oGuid) =>
      http.postJson('/Give/Accept', data: {'o_guid': oGuid});
}
