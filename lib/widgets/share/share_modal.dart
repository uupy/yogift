import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'share_menu_item.dart';

class ShareModal {
  ShareModal._();

  static Future show({
    String? title,
    bool showClose = false,
  }) async {
    app.showBottomModal(
      context: Get.context!,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.w,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      title ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (showClose)
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppAssetImage(
                        width: 24.w,
                        margin: EdgeInsets.only(right: 20.w, top: 6.w),
                        img: 'icon_close.png',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height / 2 - 40.w),
              child: GridView.extent(
                padding: EdgeInsets.all(4.w),
                maxCrossAxisExtent: 125.w,
                childAspectRatio: 1.3,
                mainAxisSpacing: 4.w,
                crossAxisSpacing: 4.w,
                children: [
                  ShareMenuItem(
                    name: 'WhatsApp',
                    img: 'icon_whatsapp.png',
                    onTap: () {},
                  ),
                  ShareMenuItem(
                    name: 'Facebook Messenger',
                    img: 'icon_facebook.png',
                    onTap: () {},
                  ),
                  ShareMenuItem(
                    name: 'Twitter',
                    img: 'icon_twitter.jpg',
                    onTap: () {},
                  ),
                  ShareMenuItem(
                    name: 'Instagram',
                    img: 'icon_instagram.png',
                    onTap: () {},
                  ),
                  ShareMenuItem(
                    name: 'WeChat',
                    img: 'icon_wechat.png',
                    onTap: () {},
                  ),
                  ShareMenuItem(
                    name: '短訊',
                    img: 'icon_message.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
