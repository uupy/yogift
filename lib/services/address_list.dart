import 'package:yo_gift/common/http.dart';

/// 區域接口服务
class AddressListService {
  AddressListService._();

  /// 二级列表
  /// 頂級 [parentId] 用 0
  static Future queryList(int parentId) =>
      http.postJson('/AddressList/List2', data: {'parent_id': parentId});
}
