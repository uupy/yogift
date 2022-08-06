import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class SearchResultController extends GetxController {
  final inputController = TextEditingController();
  final listController = AppListController<GiftVo>();
  String giftname = Get.parameters['keyword'] ?? '';
  int? orderby;
  int? sendingmethod;
  int total = 0;

  void init() {
    inputController.text = giftname;
    update(['SearchBar']);
  }

  Future<List<GiftVo>> queryList(Map<String, dynamic> params) async {
    params['giftname'] = giftname;
    if (orderby != null) {
      params['orderby'] = orderby;
    }
    if (sendingmethod != null) {
      params['sendingmethod'] = sendingmethod;
    }
    final res = await GiftService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => GiftVo.fromJson(e)).toList();
  }

  void onFilterChange(int? value) {
    sendingmethod = value;
    listController.onReload();
    update(['ToolBar']);
  }

  void onSortChange(int? value) {
    orderby = value;
    listController.onReload();
    update(['ToolBar']);
  }
}
