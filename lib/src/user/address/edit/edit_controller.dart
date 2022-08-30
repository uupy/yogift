import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/services/address_list.dart';
import 'package:yo_gift/services/receiving_address.dart';

class AddressEditController extends GetxController {
  final id = Get.parameters['id'] ?? '';
  final form = ReceivingAddressAddVo();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  List<AreaVo> areaList1 = [];
  List<AreaVo> areaList2 = [];

  bool get isEdit {
    return id.isNotEmpty;
  }

  bool get submitAble {
    final contact = form.contact ?? '';
    final phone = form.phone ?? '';
    final address = form.address ?? '';
    if (form.area0Id == null || form.area1Id == null) {
      return false;
    }
    return contact.isNotEmpty && phone.isNotEmpty && address.isNotEmpty;
  }

  void init() {
    queryAreaList(0);
  }

  Future queryAreaList(int? parentId) async {
    if (parentId != null) {
      final res = await AddressListService.queryList(parentId);
      final data = res.data ?? {};
      final List items = data['data'] ?? [];

      if (parentId == 0) {
        areaList1 = items.map((e) => AreaVo.fromJson(e)).toList();
      } else {
        areaList2 = items.map((e) => AreaVo.fromJson(e)).toList();
      }
    } else {
      areaList2.clear();
    }
    update();
  }

  Future onSubmit() async {
    final formData = form.toJson();
    if (isEdit) {
      formData['id'] = id;
      await ReceivingAddressService.edit(formData);
    } else {
      await ReceivingAddressService.add(formData);
    }

    Get.back(result: true);
  }

  Future onRemove() async {
    await ReceivingAddressService.remove(id);
    app.showToast('刪除成功');
    await Future.delayed(const Duration(milliseconds: 300));
    Get.back(result: true);
  }
}
