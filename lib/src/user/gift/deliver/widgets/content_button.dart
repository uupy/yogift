import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/contact_modal.dart';

import '../deliver_controller.dart';

class ContentButton extends StatelessWidget {
  const ContentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftDeliverController>(
      builder: (c) {
        if (c.detail?.orderStatus == 1) {
          return Container(
            margin: EdgeInsets.fromLTRB(20.w, 24.w, 20.w, 24.w),
            child: AppButton(
              text: '確定兌換禮物',
              shadow: true,
              onPressed: () {
                final addr = ReceivingAddressVo();
                addr.contact = c.detail?.receivingaddressContact;
                addr.phone = c.detail?.receivingaddressPhone;
                addr.address = c.detail?.receivingaddressAddress;
                addr.area0 = c.detail?.receivingaddressArea0;
                addr.area1 = c.detail?.receivingaddressArea1;
                c.showAddressInfo(addr);
              },
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            app.showBottomModal(
              context: context,
              builder: (BuildContext context) {
                return const ContactModal();
              },
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: Text(
              '聯絡客戶服務',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xff007aff),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      },
    );
  }
}
