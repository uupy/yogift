import 'package:get/get.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class SearchCategoryController extends GetxController {
  final pageType = Get.parameters['pageType'] ?? '1';
  final categoryId = Get.parameters['id'];
  final listController = AppListController<GiftVo>();
  final title = '禮物類型'.obs;
  int? orderBy;
  int? sendingMethod;
  int total = 0;
  int tabIndex = 0;
  List<GiftCategoryVo> categoryList = [];
  GiftCategoryVo? currentCategory;

  Future init() async {
    if (pageType == '2') {
      title('送禮場景');
    } else {
      title('禮物類型');
    }
    await queryCategoryList();
    listController.onReload();
  }

  Future<List<GiftVo>> queryList(Map<String, dynamic> params) async {
    if (currentCategory != null) {
      if (pageType == '2') {
        params['scene_id'] = currentCategory!.id;
      } else {
        params['gc_guid'] = currentCategory!.gcGuid;
      }
    }

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

  /// 获取分類
  Future queryCategoryList() async {
    dynamic res;
    if (pageType == '2') {
      /// 获取場景
      res = await GiftService.querySceneList();
    } else {
      res = await GiftService.queryClassList();
    }
    final List data = res.data['data'] ?? [];
    categoryList = data.map((e) => GiftCategoryVo.fromJson(e)).toList();
    if (categoryList.isNotEmpty) {
      currentCategory =
          categoryList.singleWhere((e) => e.id == int.parse(categoryId ?? ''));
      currentCategory ??= categoryList.first;
      tabIndex = categoryList.indexOf(currentCategory!);
    }
    update(['CategoryTabsBar']);
  }

  void onCategoryChanged(int index) {
    tabIndex = index;
    currentCategory = categoryList[index];
    listController.onReload();
    update(['CategoryTabsBar']);
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
