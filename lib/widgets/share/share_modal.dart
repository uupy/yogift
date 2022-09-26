import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:social_share/social_share.dart';
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
    String? imageUrl,
  }) async {
    String shareContent = shareUrl;
    String imagePath = imageUrl ?? '';

    if (imagePath.isNotEmpty && !imagePath.contains('?imageMogr2/thumbnail/')) {
      imagePath = '$imagePath?imageMogr2/thumbnail/200x200';
    }

    if (msg?.isNotEmpty ?? false) {
      shareContent = '【$msg】 $shareUrl';
    }

    try {
      await Clipboard.setData(ClipboardData(text: shareContent));

      logger.i('shareUrl: $shareUrl');
      // app.showToast('鏈接已複製');
      SmartDialog.showLoading(msg: '加載中...');

      switch (method) {
        case ShareMethod.whatsApp:
          await flutterShareMe.shareToWhatsApp(
            msg: shareContent,
            imagePath: imagePath,
          );
          break;
        case ShareMethod.facebook:
          // await flutterShareMe.shareToFacebook(msg: msg ?? '', url: shareUrl);
          final filePath = await getImagePath(imagePath);
          await SocialShare.shareFacebookStory(
            filePath,
            '#ffffff',
            '#000000',
            shareUrl,
            appId: Env.config.facebookAppId,
          );
          break;
        case ShareMethod.twitter:
          await flutterShareMe.shareToTwitter(msg: msg ?? '', url: shareUrl);
          break;
        case ShareMethod.instagram:
          if (imagePath.isNotEmpty) {
            final filePath = await getImagePath(imagePath);
            await SocialShare.shareInstagramStory(
              filePath,
              backgroundTopColor: "#ffffff",
              backgroundBottomColor: "#000000",
              attributionURL: shareUrl,
            );
          }
          break;
        case ShareMethod.weChat:
          await shareToWechat(shareUrl, msg, imagePath: imagePath);
          break;
        case ShareMethod.sms:
          const phone = '';
          if (Platform.isAndroid) {
            launchUrl(
                Uri.parse('sms:$phone?body=${Uri.encodeComponent(shareUrl)}'));
          } else if (Platform.isIOS) {
            launchUrl(
                Uri.parse('sms:$phone&body=${Uri.encodeComponent(shareUrl)}'));
          }

          break;
      }
    } catch (err) {
      logger.e(err.toString());
    } finally {
      SmartDialog.dismiss();
    }
  }

  static Future<String> getImagePath(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);
    logger.i(file.path);
    return file.path;
  }

  static Future shareToWechat(String url, String? msg,
      {String imagePath = ''}) async {
    logger.i(Env.config.wxAppId);
    await fluwx.registerWxApi(
      appId: Env.config.wxAppId,
      universalLink: Env.config.universalLink,
    );
    final isInstalled = await fluwx.isWeChatInstalled;

    if (isInstalled) {
      await fluwx.shareToWeChat(
        fluwx.WeChatShareWebPageModel(
          url,
          title: 'YO!GIFT',
          description: msg,
          thumbnail: imagePath.isNotEmpty
              ? fluwx.WeChatImage.network(imagePath)
              : null,
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
    String? imageUrl,
    bool showClose = false,
  }) async {
    final showHeader = showClose || (title?.isNotEmpty ?? false);
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
              height: showHeader ? 60.w : 10.w,
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
            SizedBox(
              height: 200.w,
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
                        imageUrl: imageUrl,
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
                        imageUrl: imageUrl,
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
                        imageUrl: imageUrl,
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
                        imageUrl: imageUrl,
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
                        imageUrl: imageUrl,
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
