import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class SearchResultController extends GetxController {
  final inputController = TextEditingController();
  final listController = AppListController<GiftVo>();
  String giftName = Get.parameters['keyword'] ?? '';
  int? orderBy;
  int? sendingMethod;
  int total = 0;

  void init() {
    inputController.text = giftName;
    update(['SearchBar']);
  }

  Future<List<GiftVo>> queryList(Map<String, dynamic> params) async {
    params['giftname'] = giftName;
    if (orderBy != null) {
      params['orderby'] = orderBy;
    }
    if (sendingMethod != null) {
      params['sendingmethod'] = sendingMethod;
    }
    final res = await GiftService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => GiftVo.fromJson(e)).toList();
  }

  void onSendingMethodChange(int? value) {
    sendingMethod = value;
    listController.onReload();
    update(['ToolBar']);
  }

  void onSortChange(int? value) {
    orderBy = value;
    listController.onReload();
    update(['ToolBar']);
  }
}
