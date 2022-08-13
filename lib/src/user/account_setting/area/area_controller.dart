import 'package:get/get.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/services/address_list.dart';
import 'package:yo_gift/services/user.dart';

class AccountSettingAreaController extends GetxController {
  List<AreaVo> areaList1 = [];
  List<AreaVo> areaList2 = [];
  AreaVo? parent;
  AreaVo? selected;
  bool submitting = false;

  @override
  void onInit() {
    fetchData(0);
    super.onInit();
  }

  Future fetchData(int parentId) async {
    final res = await AddressListService.queryList(parentId);
    final data = res.data ?? {};
    final List items = data['data'] ?? [];
    final _list = items.map((e) => AreaVo.fromJson(e)).toList();
    if (parentId == 0) {
      areaList1 = _list;
      update(['Area1Page']);
    } else {
      areaList2 = _list;
      selected = null;
      update(['Area2Page', 'Area2Action']);
    }
  }

  Future onSubmit() async {
    if (selected == null || submitting) return;
    final data = {
      'area0_id': parent!.id,
      'area1_id': selected!.id,
    };
    submitting = true;
    try {
      await UserService.updateArea(data);
      Get.back(result: true);
    } finally {
      submitting = false;
    }
  }
}
