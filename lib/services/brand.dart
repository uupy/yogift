import 'package:yo_gift/common/http.dart';

/// 品牌接口服务
class BrandService {
  BrandService._();

  /// 首页行业分类带品牌
  static Future queryBrandCategories() =>
      http.get('/Brand/HomePage_List_industry');

  /// 列出所有品牌icon
  static Future queryBrandList() => http.get('/Brand/List_icon');
}
