import 'package:get/get.dart';
import 'package:yo_gift/services/common.dart';

class ClauseController extends GetxController {
  String type = "";
  String content = "";
  @override
  void onInit() {
    queryList();
    super.onInit();
  }

  Future queryList() async {
    final res = await CommonService.queryClassContent('clause');
    final data = res.data ?? {};
    final obj = data['data'] ?? {};
    type = obj['Type1'];
    content = obj['Content'];
    update();
  }

  Future init() async {
    update();
  }
}
