import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/share/share_modal.dart';

import '../detail_controller.dart';

class OrderDetailFooter extends StatelessWidget {
  final Function(int type)? onTap;

  const OrderDetailFooter({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      id: 'OrderDetailFooter',
      builder: (c) {
        final item = c.detail;
        final payStatus = item?.payStatus;
        final orderStatus = item?.orderStatus;
        final isBuy1Free1 = item?.buy1Get1FREE == 1;
        final canIExchange = !isBuy1Free1 && orderStatus == 1;
        final canIGive = orderStatus == 1 && item?.isGive == 0;

        List<Widget> children = [];

        if (payStatus == 1) {
          children.addAll([
            buildFooterItem(
              text: '關閉訂單',
              background: const Color(0xfffffdeb),
              onTap: c.onCloseOrder,
            ),
            SizedBox(width: 15.w),
            buildFooterItem(
              text: '繼續支付',
              onTap: () {
                Get.toNamed(
                  '/pages/goods/purchase/index',
                  parameters: {
                    'buyType': '1',
                    'id': item!.gGuid!,
                    'skuId': '${item.skuId}',
                    'orderId': item.oGuid!,
                  },
                )?.then((value) {
                  c.fetchData();
                });
              },
            ),
          ]);
        } else if (payStatus == 2) {
          if (orderStatus == 1) {
            if (canIExchange) {
              children.add(buildFooterItem(
                text: '前往兌換',
                background: const Color(0xfffffdeb),
                onTap: () {
                  final Map<String, String> parameters = {
                    'id': item!.oGuid!,
                  };
                  String path = '/pages/mine/gift/exchange/index';
                  if (item.sendingMethod == 2) {
                    path = '/pages/mine/gift/deliver/index';
                  }
                  Get.toNamed(path, parameters: parameters)?.then((value) {
                    c.fetchData();
                  });
                },
              ));
            }
            if (canIExchange && canIGive) {
              children.add(SizedBox(width: 15.w));
            }
            if (canIGive) {
              children.add(buildFooterItem(
                text: '贈送好友',
                icon: 'icon_mine_gift.png',
                onTap: () {
                  ShareModal.show(
                    title: '你想如何贈送好友？',
                    type: 0,
                    id: c.detail?.oGuid ?? '',
                    goodsName: c.detail?.giftName ?? '',
                  );
                },
              ));
            }
          }
        }

        if (children.isEmpty) {
          return Container();
        }

        return Container(
          height: 68.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
          decoration: BoxDecoration(
            color: const Color(0xfffffdeb),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
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
    Function()? onTap,
  }) {
    return SizedBox(
      width: 140.w,
      child: AppButton(
        onPressed: onTap,
        backgroundColor: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon?.isNotEmpty ?? false)
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
