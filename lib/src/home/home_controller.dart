import 'package:get/get.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/models/gift.dart';
import 'package:yo_gift/services/common.dart';
import 'package:yo_gift/services/gift.dart';

class HomeController extends GetxController {
  bool bannerLoading = false;
  List<BannerVo> banners = [];
  int currentBannerIndex = 0;

  /// 7天top13
  List<HomeGiftVo> top7DaysList = [];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    queryBannerList();
    queryTop13();
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
      update();
    }
  }

  /// banner图切换
  onBannerChanged(int index) {
    currentBannerIndex = index;
    update();
  }

  /// 查询top13
  Future queryTop13() async {
    final res = await GiftService.queryTop7Days();
    final List data = res.data['data'] ?? [];
    top7DaysList = data.map((e) => HomeGiftVo.fromJson(e)).toList();
    update();
  }
}
