import 'package:yo_gift/common/http.dart';

/// 礼物接口服务
class GiftService {
  GiftService._();

  /// 首页7天排行榜Top13
  static Future queryTop7Days() => http.get('/Gift/HomePage_List_Top7Days');

  /// 清单(带搜索)
  static Future queryGiftList(data) =>
      http.postJson('/Gift/List_Search', data: data);
}