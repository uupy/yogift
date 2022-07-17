import 'package:yo_gift/common/http.dart';

/// 公共接口服务
class CommonService {
  CommonService._();

  /// 获取基本配置
  static Future getConfig() => http.get('/Common/GetConfig');

  /// 获取banner图
  static Future getBanners(String type) =>
      http.postJson('/Common/GetBannerImageList', data: {'type1': type});
}
