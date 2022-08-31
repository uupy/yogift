import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/receiving_address.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_card.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import '../list_controller.dart';

class AddressItemCard extends StatelessWidget {
  final ReceivingAddressVo item;
  const AddressItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListController>(
      builder: (c) {
        final address = item.address ?? '';
        final area0 = item.area0 ?? '';
        final area1 = item.area1 ?? '';
        final contact = item.contact ?? '';
        final phone = item.phone ?? '';

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: Row(
            children: [
              if (c.selected?.id == item.id)
                AppAssetImage(
                  width: 16.w,
                  margin: EdgeInsets.only(right: 8.w),
                  img: 'icon_cb_1.png',
                ),
              Expanded(
                child: AppCard(
                  onTap: () {
                    c.selected = item;
                    c.update();
                  },
                  behavior: HitTestBehavior.deferToChild,
                  blurRadius: 0,
                  padding: EdgeInsets.fromLTRB(20.w, 10.w, 10.w, 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSimpleRow(
                        expanded: Text(
                          '$area0$area1$address',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        suffix: AppAssetImage(
                          width: 40.w,
                          padding: EdgeInsets.all(10.w),
                          img: 'icon_edit2.png',
                          onTap: () {
                            Get.toNamed(
                              '/pages/mine/addr-edit/index',
                              arguments: item,
                            )?.then((value) {
                              if (value == true) {
                                c.onReload();
                              }
                            });
                          },
                        ),
                      ),
                      Text(
                        '$contact $phone',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
