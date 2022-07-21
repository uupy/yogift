import 'package:yo_gift/common/http.dart';

/// 机构接口服务
class CharityService {
  CharityService._();

  /// 分类
  static Future queryClassList() => http.get('/Charity/List_Class');

  /// 所有icon
  static Future queryIconList() => http.get('/Charity/List_Icon');

  /// 分页查询
  static Future queryCharityPage(data) =>
      http.postJson('/Charity/List_Search', data: data);

  /// 捐贈首页分类带机构
  static Future getCharity(String id) => http.postJson('/Charity/Item', data: {
        'id_guid': id,
      });

  /// 捐贈首页分类带机构
  static Future queryCharityList() => http.get('/Charity/HomePage_List_Icon');
}
