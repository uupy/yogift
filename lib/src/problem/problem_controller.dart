import 'package:get/get.dart';
import 'package:yo_gift/services/common.dart';

class ProblemController extends GetxController {
  String type = "";
  String content = "";

  @override
  void onInit() {
    queryList();
    super.onInit();
  }

  Future queryList() async {
    final res = await CommonService.queryClassContent('help');
    final data = res.data ?? {};
    final obj = data['data'] ?? {};
    type = obj['Type1'];
    content = obj['Content'] ?? '';
    // content = content.replaceAll('\n', '<br />');
    update();
  }
}