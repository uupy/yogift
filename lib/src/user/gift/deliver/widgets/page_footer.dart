import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';

import '../deliver_controller.dart';

class GiftDeliverFooter extends StatelessWidget {
  final Function(int type)? onTap;

  const GiftDeliverFooter({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftDeliverController>(
      builder: (c) {
        final orderStatus = c.detail?.orderStatus;

        List<Widget> children = [];

        if (orderStatus == 3) {
          children.addAll([
            buildFooterItem(
              text: '確認收貨',
              loading: c.submitting,
              onTap: c.onReceivingConfirm,
            ),
          ]);
        }

        if (children.isEmpty) {
          return Container();
        }

        return Container(
          height: 68.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  Widget buildFooterItem({
    String? text,
    String? icon,
    Color? background,
    bool loading = false,
    Function()? onTap,
  }) {
    return Expanded(
      child: AppButton(
        onPressed: onTap,
        loading: loading,
        backgroundColor: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssetImage(
              img: icon,
              width: 16.w,
              margin: EdgeInsets.only(right: 5.w),
            ),
            Text(
              text ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromRGBO(0, 0, 0, 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
