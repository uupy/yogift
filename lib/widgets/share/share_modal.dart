import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'share_menu_item.dart';

class ShareModal {
  ShareModal._();

  static Future show({
    /// 彈窗標題
    String? title,

    /// 分类类型: 0 = 赠送好友 1=商品 3=拜托好友 4=商户页面
    int type = 0,

    /// 对应的id /订单id/商品id/拜托id/商户id
    String id = '',
    String msg = '',
    bool showClose = false,
  }) async {
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    final url = Env.config.baseUrl.replaceFirst('api', 'url');
    String shareUrl = '$url/s/$type/$id';
    String shareContent = '';

    if (type == 0) {
      shareUrl = '$url/g/$id';
    }

    if (msg.isNotEmpty) {
      shareContent = '【$msg】 $shareUrl';
    }

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
                    onTap: () async {
                      // final uri = Uri.parse('whatsapp://send?link=$shareUrl');
                      // if (!await launchUrl(uri)) {
                      //   await Clipboard.setData(ClipboardData(text: shareUrl));
                      //   app.showToast('打開WhatsApp失敗，分享鏈接已複製');
                      // }
                      await Clipboard.setData(
                          ClipboardData(text: shareContent));
                      await flutterShareMe.shareToWhatsApp(msg: shareContent);
                    },
                  ),
                  ShareMenuItem(
                    name: 'Facebook Messenger',
                    img: 'icon_facebook.png',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: shareContent));
                      await flutterShareMe.shareToFacebook(
                          msg: msg, url: shareUrl);
                    },
                  ),
                  ShareMenuItem(
                    name: 'Twitter',
                    img: 'icon_twitter.jpg',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: shareContent));
                      await flutterShareMe.shareToTwitter(
                          msg: msg, url: shareUrl);
                    },
                  ),
                  ShareMenuItem(
                    name: 'Instagram',
                    img: 'icon_instagram.png',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: shareContent));
                      app.showToast('鏈接已複製');
                      // await flutterShareMe.shareToInstagram(msg: shareUrl);
                    },
                  ),
                  ShareMenuItem(
                    name: 'WeChat',
                    img: 'icon_wechat.png',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: shareContent));
                      await fluwx.shareToWeChat(
                        fluwx.WeChatShareWebPageModel(
                          shareUrl,
                          description: msg,
                        ),
                      );
                    },
                  ),
                  ShareMenuItem(
                    name: '短訊',
                    img: 'icon_message.png',
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: shareContent));
                      launchUrl(Uri.parse("sms:"));
                    },
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
