import 'package:get/get.dart';
import 'package:yo_gift/models/brand.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/brand.dart';
import 'package:yo_gift/services/common.dart';
import 'package:yo_gift/services/gift.dart';

class HomeController extends GetxController {
  bool bannerLoading = false;
  List<BannerVo> banners = [];
  int currentBannerIndex = 0;

  /// 7天top13
  List<HomeGiftVo> top7DaysList = [];

  /// 品牌列表
  List<BrandCategoryVo> brandCategories = [];
  List<BrandBussinessVo> currentBrandList = [];
  int? currentCategoryId;

  /// 推荐
  List<RecommendTitleVo> recommendTitles = [];
  List<GiftVo> recommendGiftList = [];
  String? currentRecommendTitle;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    queryBannerList();
    queryTop13();
    queryBrandCategories();
    queryRecommendTitles();
  }

  /// 获取banner数据
  Future queryBannerList() async {
    bannerLoading = true;
    update();
    try {
      final res = await CommonService.getBanners('home');
      final List data = res.data['data'] ?? [];
      banners = data.map((e) => BannerVo.fromJson(e)).toList();
    } finally {
      bannerLoading = false;
      update(['bannerWrapper']);
    }
  }

  /// banner图切换
  onBannerChanged(int index) {
    currentBannerIndex = index;
    update(['bannerWrapper']);
  }

  /// 查询top13
  Future queryTop13() async {
    final res = await GiftService.queryTop7Days();
    final List data = res.data['data'] ?? [];
    top7DaysList = data.map((e) => HomeGiftVo.fromJson(e)).toList();
    update(['top13Wrapper']);
  }

  /// 查询top13
  Future queryBrandCategories() async {
    final res = await BrandService.queryBrandCategories();
    final List data = res.data['data'] ?? [];
    brandCategories = data.map((e) => BrandCategoryVo.fromJson(e)).toList();
    if (brandCategories.isNotEmpty) {
      final item = brandCategories.first;
      currentCategoryId = item.id;
      currentBrandList = item.bussiness ?? [];
    }
    update(['brandWrapper']);
  }

  onCategoryChanged(int index) {
    final item = brandCategories[index];
    currentCategoryId = item.id;
    currentBrandList = item.bussiness ?? [];
    update(['brandWrapper']);
  }

  /// 获取推荐关键词
  Future queryRecommendTitles() async {
    final res = await CommonService.getRecommendList('home');
    final List data = res.data['data'] ?? [];
    recommendTitles = data.map((e) => RecommendTitleVo.fromJson(e)).toList();
    update(['recommendWrapper']);
    queryGiftList();
  }

  Future queryGiftList() async {
    final Map<String, dynamic> params = {
      'pageindex': 1,
      'pagesize': 5,
    };
    if (currentRecommendTitle?.isNotEmpty ?? false) {
      params['giftname'] = currentRecommendTitle;
    }
    final res = await GiftService.queryGiftList(params);
    final List data = res.data['data'] ?? [];
    recommendGiftList = data.map((e) => GiftVo.fromJson(e)).toList();
    update(['recommendWrapper']);
  }

  onRecommendTitleChanged(String? title) {
    currentRecommendTitle = title;
    queryGiftList();
    update(['brandWrapper']);
  }
}
