import 'package:get/get.dart';
import 'package:yo_gift/models/common.dart';
import 'package:yo_gift/services/common.dart';

class HomeController extends GetxController {
  bool bannerLoading = false;
  List<BannerVo> banners = [];
  int currentBannerIndex = 0;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future init() async {
    queryBannerList();
  }

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

  onBannerChanged(int index) {
    currentBannerIndex = index;
    update();
  }
}
