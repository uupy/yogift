import 'package:yo_gift/common/http.dart';
import 'package:yo_gift/models/gift_request.dart';

/// 礼物拜託接口服务
class GiftRequestService {
  GiftRequestService._();

  /// 送礼场景清单
  static Future add(GiftRequestAddVo data) =>
      http.postJson('/Giftrequest/Add', data: data);
}
