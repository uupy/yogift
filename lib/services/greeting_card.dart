import 'package:yo_gift/common/http.dart';

class GreetingCardService {
  GreetingCardService._();

  /// 清单
  /// 页码 [pageindex] 必须
  /// 每页条数 [pagesize] 必须
  /// 类型 [type1] 0全部，1拜托专用，2非拜托卡
  static Future queryPage(data) =>
      http.postJson('/Greetingcard/List_Search', data: data);
}
