import 'package:get/get.dart';
import 'package:yo_gift/models/charity.dart';
import 'package:yo_gift/models/charity_favorites.dart';
import 'package:yo_gift/services/charity.dart';
import 'package:yo_gift/services/charity_favorites.dart';

class CharityDetailController extends GetxController {
  final id = Get.parameters['id'];
  CharityItemVo? detail;
  bool expendDetail = false;
  int current = 1;
  int pageSize = 20;
  List<CharityFavoritesItemVo> list = [];

  Future fetchData() async {
    final res = await CharityService.getCharity(id!);
    final data = res.data ?? {};
    detail = CharityItemVo.fromJson(data['data'] ?? {});
    update(['BaseInfo']);
  }

  Future queryList() async {
    final params = {
      'c_guid': id,
      'pageindex': current,
      'pagesize': pageSize,
    };
    final res = await CharityFavoritesService.queryHomeList(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    final _list = items.map((e) => CharityFavoritesItemVo.fromJson(e)).toList();
    if (current == 1) {
      list.clear();
    }
    list.addAll(_list);
    update(['FavoritesList']);
  }
}
