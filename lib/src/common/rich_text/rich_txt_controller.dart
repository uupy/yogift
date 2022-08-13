import 'package:get/get.dart';
import 'package:yo_gift/services/common.dart';

class RichTxtController extends GetxController {
  final type = Get.parameters['type'];
  final title = ''.obs;
  String content = '';

  @override
  void onInit() {
    final titles = {
      'clause': '條款及細則',
      'help': '常見問題',
    };
    title(titles[type]);
    fetchData();
    super.onInit();
  }

  Future fetchData() async {
    if (type?.isNotEmpty ?? false) {
      final res = await CommonService.queryClassContent(type!);
      final data = res.data ?? {};
      final obj = data['data'] ?? {};
      content = obj['Content'] ?? '';
      content = content.replaceAll('\n', '<br />');
      update();
    }
  }
}
