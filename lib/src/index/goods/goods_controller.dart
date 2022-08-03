import 'package:get/get.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/common.dart';
import 'package:yo_gift/services/gift.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_controller.dart';

class GoodsController extends GetxController {
  List<RecommendTitleVo> recommendTitles = [];
  List<GiftCategoryVo> categoryList = [];
  List<GiftSceneVo> sceneList = [];

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
  }

  Future<List<GiftVo>> queryList(Map<String, dynamic> params) async {
    params['pricen'] = pricen;
    if (orderby != null) {
      params['orderby'] = orderby;
    }
    final res = await GiftService.queryPage(params);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    return items.map((e) => GiftVo.fromJson(e)).toList();
  }

  void onFilterChange(int value) {
    pricen = value;
    listController.onReload();
  }

  void onSortChange(int? value) {
    orderby = value;
    listController.onReload();
    update(['sortBar']);
  }

  /// 获取推荐关键词
  Future queryRecommendTitles() async {
    final res = await CommonService.getRecommendList('gift');
    final List data = res.data['data'] ?? [];
    recommendTitles = data.map((e) => RecommendTitleVo.fromJson(e)).toList();
    update(['recommendWrapper']);
  }

  /// 获取分類
  Future queryCategoryList() async {
    final res = await GiftService.queryClassList();
    final List data = res.data['data'] ?? [];
    categoryList = data.map((e) => GiftCategoryVo.fromJson(e)).toList();
    update(['categoryList']);
  }

  /// 获取場景
  Future querySceneList() async {
    final res = await GiftService.querySceneList();
    final List data = res.data['data'] ?? [];
    sceneList = data.map((e) => GiftSceneVo.fromJson(e)).toList();
    update(['sceneList']);
  }
}
