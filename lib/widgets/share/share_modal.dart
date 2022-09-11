import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'share_menu_item.dart';

class ShareModal {
  ShareModal._();

  static final FlutterShareMe flutterShareMe = FlutterShareMe();

  static Future onShare({
    required ShareMethod method,
    required String shareUrl,
    String? msg,
  }) async {
    String shareContent = shareUrl;

    if (msg?.isNotEmpty ?? false) {
      shareContent = '【$msg】 $shareUrl';
    }

    try {
      await Clipboard.setData(ClipboardData(text: shareContent));

      logger.i('shareUrl: $shareUrl');
      app.showToast('鏈接已複製');

      switch (method) {
        case ShareMethod.whatsApp:
          await flutterShareMe.shareToWhatsApp(msg: shareContent);
          break;
        case ShareMethod.facebook:
          await flutterShareMe.shareToFacebook(msg: msg ?? '', url: shareUrl);
          break;
        case ShareMethod.twitter:
          await flutterShareMe.shareToTwitter(msg: msg ?? '', url: shareUrl);
          break;
        case ShareMethod.instagram:
          break;
        case ShareMethod.weChat:
          await shareToWechat(shareUrl, msg);
          break;
        case ShareMethod.sms:
          // launchUrl(Uri(
          //   scheme: 'sms',
          //   path: '',
          //   queryParameters: <String, String>{
          //     'body': Uri.encodeComponent(shareUrl),
          //   },
          // ));
          launchUrl(Uri.parse('sms:?body=${Uri.encodeComponent(shareUrl)}'));
          break;
      }
    } catch (err) {
      logger.e(err.toString());
    }
  }

  static Future shareToWechat(String url, String? msg) async {
    logger.i(Env.config.wxAppId);
    await fluwx.registerWxApi(appId: Env.config.wxAppId);
    final isInstalled = await fluwx.isWeChatInstalled;
    if (isInstalled) {
      await fluwx.shareToWeChat(
        fluwx.WeChatShareWebPageModel(
          url,
          description: msg,
        ),
      );
    } else {
      app.showToast('請先安裝WeChat');
    }
  }

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
    final url = Env.config.baseUrl.replaceFirst('api', 'url');
    String shareUrl = '$url/s/$type/$id';

    if (type == 0) {
      shareUrl = '$url/g/$id';
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
                    onTap: () {
                      onShare(
                        method: ShareMethod.whatsApp,
                        shareUrl: shareUrl,
                        msg: msg,
                      );
                    },
                  ),
                  ShareMenuItem(
                    name: 'Facebook Messenger',
                    img: 'icon_facebook.png',
                    onTap: () async {
                      onShare(
                        method: ShareMethod.facebook,
                        shareUrl: shareUrl,
                        msg: msg,
                      );
                    },
                  ),
                  ShareMenuItem(
                    name: 'Twitter',
                    img: 'icon_twitter.jpg',
                    onTap: () async {
                      onShare(
                        method: ShareMethod.twitter,
                        shareUrl: shareUrl,
                        msg: msg,
                      );
                    },
                  ),
                  ShareMenuItem(
                    name: 'Instagram',
                    img: 'icon_instagram.png',
                    onTap: () async {
                      onShare(
                        method: ShareMethod.instagram,
                        shareUrl: shareUrl,
                        msg: msg,
                      );
                    },
                  ),
                  ShareMenuItem(
                    name: 'WeChat',
                    img: 'icon_wechat.png',
                    onTap: () async {
                      onShare(
                        method: ShareMethod.weChat,
                        shareUrl: shareUrl,
                        msg: msg,
                      );
                    },
                  ),
                  ShareMenuItem(
                    name: '短訊',
                    img: 'icon_message.png',
                    onTap: () async {
                      onShare(
                        method: ShareMethod.sms,
                        shareUrl: shareUrl,
                        msg: msg,
                      );
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
