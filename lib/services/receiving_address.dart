import 'package:yo_gift/common/http.dart';

/// 收货地址接口服务
class ReceivingAddressService {
  ReceivingAddressService._();

  /// 列表
  static Future queryList(data) =>
      http.postJson('/ReceivingAddress/List', data: data);

  /// 添加
  static Future add(data) => http.postJson('/ReceivingAddress/Add', data: data);

  /// 编辑
  static Future edit(data) =>
      http.postJson('/ReceivingAddress/Edit', data: data);

  /// 删除
  static Future remove(id) =>
      http.postJson('/ReceivingAddress/Delete', data: {'id': id});
}
