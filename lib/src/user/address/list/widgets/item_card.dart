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
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSimpleRow(
                        margin: EdgeInsets.only(bottom: 4.w),
                        expanded: Text(
                          '$area0$area1$address',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        suffix: AppAssetImage(
                          width: 20.w,
                          img: 'icon_edit2.png',
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
