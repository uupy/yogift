import 'package:dio/dio.dart';
import 'package:yo_gift/common/http.dart';

/// 礼物接口服务
class GiftService {
  GiftService._();

  /// 首页7天排行榜Top13
  static Future queryTop7Days() => http.get('/Gift/HomePage_List_Top7Days');

  /// 首页探索更多产品,分页加载
  static Future queryListExplore(data) =>
      http.postJson('/Gift/HomePage_List_Explore', data: data);

  /// 清单(带搜索)
  static Future queryPage(data) =>
      http.postJson('/Gift/List_Search', data: data);

  /// 类型清单
  static Future queryClassList() => http.get('/Gift/List_Class');

  /// 送礼场景清单
  static Future querySceneList() => http.get('/Gift/List_Scene');

  /// 送礼场景清单
  static Future getGift(String id) => http.postJson('/Gift/Item',
      data: {'id_guid': id},
      options: Options(
        extra: {
          'ignoreErrors': true,
        },
      ));
}
