import 'package:yo_gift/common/http.dart';

/// 公共接口服务
class CommonService {
  CommonService._();

  /// 获取基本配置
  static Future getConfig() => http.get('/Common/GetConfig');

  /// 获取banner图
  static Future getBanners(String type) =>
      http.postJson('/Common/GetBannerImageList', data: {'type1': type});

  /// 搜索推荐关键字
  static Future getRecommendList(String type) =>
      http.postJson('/Common/GetRecomment', data: {'type1': type});

  /// 條款及細則 //常见问题 
  static Future queryClassContent(String type) =>
      http.postJson('/Common/GetMyContent', data: {'type1': type});
}
