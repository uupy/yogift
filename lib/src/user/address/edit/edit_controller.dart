import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/address_list.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/services/address_list.dart';
import 'package:yo_gift/services/receiving_address.dart';

class AddressEditController extends GetxController {
  final ReceivingAddressVo? item = Get.arguments;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final form = ReceivingAddressAddVo();

  bool submitting = false;

  List<AreaVo> areaList1 = [];
  List<AreaVo> areaList2 = [];

  bool get isEdit {
    return item != null;
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
    if (item != null) {
      form.contact = item?.contact;
      form.phone = item?.phone;
      form.address = item?.address;
      form.area0Id = item?.area0Id;
      form.area1Id = item?.area1Id;
      nameController.text = form.contact ?? '';
      phoneController.text = form.phone ?? '';
      addressController.text = form.address ?? '';
      update();
    }
    queryAreaList(0);
    if (form.area0Id != null) {
      queryAreaList(form.area0Id ?? 0);
    }
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
    submitting = true;
    update();

    try {
      if (isEdit) {
        formData['id'] = item?.id;
        await ReceivingAddressService.edit(formData);
      } else {
        await ReceivingAddressService.add(formData);
      }
      app.showToast('保存成功');
      await Future.delayed(const Duration(milliseconds: 300));
      Get.back(result: true);
    } finally {
      submitting = false;
      update();
    }
  }

  Future onRemove() async {
    await ReceivingAddressService.remove(item!.id);
    app.showToast('刪除成功');
    await Future.delayed(const Duration(milliseconds: 300));
    Get.back(result: true);
  }
}
