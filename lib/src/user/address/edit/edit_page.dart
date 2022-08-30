import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/purchase/widgets/area_select.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/form_item.dart';

import 'edit_controller.dart';

class AddressEditPage extends StatefulWidget {
  const AddressEditPage({Key? key}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  final controller = Get.put(AddressEditController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressEditController>(
      init: AddressEditController(),
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${c.isEdit ? '編輯' : '新建'}收貨地址'),
            actions: [
              if (c.isEdit)
                GestureDetector(
                  onTap: () {
                    c.onRemove();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        '删除',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xffff3b30),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormItem(
                  label: '收件人姓名',
                  hintText: '請輸入收件人姓名',
                  controller: c.nameController,
                  onChanged: (value) {
                    c.form.contact = value;
                    c.update();
                  },
                ),
                SizedBox(height: 12.w),
                FormItem(
                  label: '聯繫電話',
                  hintText: '請填寫聯繫電話',
                  controller: c.phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    c.form.phone = value;
                    c.update();
                  },
                ),
                SizedBox(height: 12.w),
                Row(
                  children: [
                    FormItem(
                      width: 96.w,
                      margin: EdgeInsets.only(right: 8.w),
                      label: '區域',
                      customInput: AreaSelect(
                        value: c.form.area0Id,
                        items: c.areaList1,
                        onChanged: (value) {
                          c.form.area0Id = value;
                          c.queryAreaList(value);
                          c.update();
                        },
                      ),
                    ),
                    Expanded(
                      child: FormItem(
                        label: ' ',
                        customInput: AreaSelect(
                          value: c.form.area1Id,
                          items: c.areaList2,
                          onChanged: (value) {
                            c.form.area1Id = value;
                            c.update();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.w),
                FormItem(
                  label: '具體地址',
                  hintText: '請填寫具體地址',
                  controller: c.addressController,
                  onChanged: (value) {
                    c.form.address = value;
                    c.update();
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(20.w),
            child: AppButton(
              text: '保存',
              disabled: !c.submitAble,
            ),
          ),
        );
      },
    );
  }
}
