import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/form_item.dart';

import '../purchase_controller.dart';
import 'area_select.dart';
import 'receiver_info_tab_bar.dart';

class ReceiverInfo extends StatefulWidget {
  const ReceiverInfo({Key? key}) : super(key: key);

  @override
  _ReceiverInfoState createState() => _ReceiverInfoState();
}

class _ReceiverInfoState extends State<ReceiverInfo> {
  final List<String> _tabItems = ['由收禮人填寫', '由送禮人填寫'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      id: 'ReceiverInfo',
      builder: (c) {
        List<Widget> children = [];

        if (c.detail?.sendingMethod != 2 || c.isGiveToSelf) {
          return Container();
        }

        if (c.receiverInfoMethod == 1) {
          children = [
            SizedBox(height: 12.w),
            FormItem(
              label: '收件人姓名',
              hintText: '請輸入收件人姓名',
              onChanged: (value) {
                c.receiverInfo.receivingaddressContact = value;
                c.update(['ReceiverInfo']);
              },
            ),
            SizedBox(height: 12.w),
            FormItem(
              label: '聯繫電話',
              hintText: '請填寫聯繫電話',
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                c.receiverInfo.receivingaddressPhone = value;
                c.update(['ReceiverInfo']);
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
                    value: c.receiverInfo.receivingaddressArea0Id,
                    items: c.areaList1,
                    onChanged: (value) {
                      c.receiverInfo.receivingaddressArea0Id = value;
                      c.queryAreaList(value);
                      c.update(['ReceiverInfo']);
                    },
                  ),
                ),
                Expanded(
                  child: FormItem(
                    label: ' ',
                    customInput: AreaSelect(
                      value: c.receiverInfo.receivingaddressArea1Id,
                      items: c.areaList2,
                      onChanged: (value) {
                        c.receiverInfo.receivingaddressArea1Id = value;
                        c.update(['ReceiverInfo']);
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
              onChanged: (value) {
                c.receiverInfo.receivingaddressAddress = value;
                c.update(['ReceiverInfo']);
              },
            ),
          ];
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '收禮人資料',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ReceiverInfoTabBar(
                items: _tabItems,
                current: c.receiverInfoMethod,
                onTap: (index) {
                  c.receiverInfoMethod = index;
                  c.update(['ReceiverInfo']);
                },
              ),
              ...children,
            ],
          ),
        );
      },
    );
  }
}
