import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app_storage.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/common.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class GoodsController extends GetxController {
  List<RecommendTitleVo> recommendTitles = [];
  List<GiftCategoryVo> categoryList = [];
  List<GiftCategoryVo> sceneList = [];
  List<String> historyList = [];

  /// 1人气(默认) 2推荐值 3最新上架 4價錢低至高 5價錢高至低
  int? orderby;

  /// 价格搜索条件 0无条件，1：50及以下 2：51-100，3：101-200，4：201-500，5：500以上
  int pricen = 1;
  AppListController<GiftVo> listController = AppListController();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    queryRecommendTitles();
    querySceneList();
    queryCategoryList();
    historyList = await searchHistory.get();
    update(['SearchHistoryBar']);
  }

  Future<List<GiftVo>> queryList(Map<String, dynamic> params) async {
    params['pricen'] = pricen;
    if (orderby != null) {
      params['orderby'] = orderby;
    }
    try {
      final res = await GiftService.queryPage(params);
      final data = res.data ?? {};
      final List items = data['data'] ?? [];
      return items.map((e) => GiftVo.fromJson(e)).toList();
    } finally {
      SmartDialog.dismiss();
    }
  }

  void onFilterChange(int value) {
    pricen = value;
    SmartDialog.showLoading(msg: '加載中...');
    listController.onReload();
  }

  void onSortChange(int? value) {
    orderby = value;
    listController.onReload();
    SmartDialog.showLoading(msg: '加載中...');
    update(['SortBar']);
  }

  /// 获取推荐关键词
  Future queryRecommendTitles() async {
    final res = await CommonService.getRecommendList('gift');
    final List data = res.data['data'] ?? [];
    recommendTitles = data.map((e) => RecommendTitleVo.fromJson(e)).toList();
    update(['SearchRecommendTitles']);
  }

  /// 获取分類
  Future queryCategoryList() async {
    final res = await GiftService.queryClassList();
    final List data = res.data['data'] ?? [];
    categoryList = data.map((e) => GiftCategoryVo.fromJson(e)).toList();
    update(['CategoryList']);
  }

  /// 获取場景
  Future querySceneList() async {
    final res = await GiftService.querySceneList();
    final List data = res.data['data'] ?? [];
    sceneList = data.map((e) => GiftCategoryVo.fromJson(e)).toList();
    update(['SceneList']);
  }

  Future saveSearchHistory(String keyword) async {
    if (historyList.contains(keyword)) {
      historyList.remove(keyword);
    }
    historyList.insert(0, keyword);
    if (historyList.length > 20) {
      historyList.removeLast();
    }
    update(['SearchHistoryBar']);
  }

  void onSearch(String keyword) async {
    await saveSearchHistory(keyword);
    Get.toNamed(
      '/pages/search/result/index',
      parameters: {'keyword': keyword},
    );
  }
}
