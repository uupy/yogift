import 'package:yo_gift/common/http.dart';

/// 机构心願单接口服务
class CharityFavoritesService {
  CharityFavoritesService._();

  /// 清单-用于单个机构首页
  static Future queryHomeList(data) => http.postJson(
        '/CharityFavorites/HomePage_List',
        data: data,
      );
}
