// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/common/app_controller.dart';
import 'package:yo_gift/common/logger.dart';
import 'package:yo_gift/config/env_config.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';

import 'share_menu_item.dart';

class ShareData {
  ShareMethod? method;
  String shareUrl;
  String? shareMsg;
  String? goodsName;
  String? imageUrl;
  String? cardImageUrl;
  String? cardMsg;

  ShareData(
      {this.method,
      required this.shareUrl,
      this.shareMsg,
      this.goodsName,
      this.imageUrl,
      this.cardImageUrl,
      this.cardMsg});
}

class ShareModal {
  ShareModal._();

  static final FlutterShareMe flutterShareMe = FlutterShareMe();

  static Future onShare(ShareData data) async {
    final method = data.method ?? ShareMethod.sms;
    String shareContent = data.shareUrl;
    String imagePath = data.imageUrl ?? '';
    String filePath = '';
    Map<dynamic, dynamic> apps = {};

    if (imagePath.isNotEmpty && !imagePath.contains('?imageMogr2/thumbnail/')) {
      String cropSize = '600';
      if (method == ShareMethod.weChat) {
        cropSize = '200x200';
      }
      imagePath = '$imagePath?imageMogr2/thumbnail/$cropSize';
    }

    if (data.shareMsg?.isNotEmpty ?? false) {
      shareContent = '${data.shareMsg}\r\n${data.shareUrl}';
    } else if (data.goodsName?.isNotEmpty ?? false) {
      shareContent = '「${data.goodsName}」\r\n${data.shareUrl}';
    }

    if (imagePath.isNotEmpty) {
      filePath = await getImagePath(imagePath);
    }

    try {
      SmartDialog.showLoading(msg: '加載中...');
      await Clipboard.setData(ClipboardData(text: shareContent));

      if (method != ShareMethod.weChat || method != ShareMethod.sms) {
        apps = await SocialShare.checkInstalledAppsForShare() ?? {};
        logger.i(apps);
      }

      logger.i({
        'filePath': filePath,
      });
      switch (method) {
        case ShareMethod.whatsApp:
          if (apps['whatsapp'] == true) {
            await flutterShareMe.shareToWhatsApp(
              msg: shareContent,
              imagePath: filePath,
            );
          } else {
            app.showToast('請先安裝WhatsApp');
          }

          break;
        case ShareMethod.facebook:
          if (apps['facebook'] == true) {
            await SocialShare.shareFacebookStory(
              filePath,
              '#ffffff',
              '#000000',
              data.shareUrl,
              appId: Env.config.facebookAppId,
            );
          } else {
            app.showToast('請先安裝Facebook');
          }
          break;
        case ShareMethod.twitter:
          if (apps['twitter'] == true) {
            await flutterShareMe.shareToTwitter(
              msg: data.shareMsg ?? data.goodsName ?? '',
              url: data.shareUrl,
            );
          } else {
            app.showToast('請先安裝Twitter');
          }
          break;
        case ShareMethod.instagram:
          if (apps['instagram'] == true) {
            await SocialShare.shareInstagramStory(
              filePath,
              backgroundTopColor: "#ffffff",
              backgroundBottomColor: "#000000",
              attributionURL: data.shareUrl,
            );
          } else {
            app.showToast('請先安裝Instagram');
          }
          break;
        case ShareMethod.weChat:
          await shareToWechat(
            data.shareUrl,
            data.goodsName,
            imagePath: imagePath,
          );
          break;
        case ShareMethod.sms:
          // const phone = '';
          // if (Platform.isAndroid) {
          //   launchUrl(Uri.parse(
          //       'sms:$phone?body=${Uri.encodeComponent(data.shareUrl)}'));
          // } else if (Platform.isIOS) {
          //   launchUrl(Uri.parse(
          //       'sms:$phone&body=${Uri.encodeComponent(data.shareUrl)}'));
          // }
          if (filePath.isNotEmpty) {
            Share.shareFiles([filePath], text: shareContent);
          } else {
            Share.share(shareContent);
          }
          break;
      }
    } catch (err) {
      logger.e(err.toString());
    } finally {
      SmartDialog.dismiss();
    }
  }

  /// 获取图片临时路径
  static Future<String> getImagePath(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);
    return file.path;
  }

  /// 分享到微信
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

  /// 打开分享弹窗
  static Future show({
    /// 彈窗標題
    String? title,

    /// 分类类型: 0 = 赠送好友 1=商品 3=拜托好友 4=商户页面
    int type = 0,

    /// 对应的id /订单id/商品id/拜托id/商户id
    String id = '',
    String goodsName = '',
    String? goodsImageUrl,
    String? cardImageUrl,
    String? cardMsg,
    bool showClose = false,
  }) async {
    final appController = Get.find<AppController>();
    final showHeader = showClose || (title?.isNotEmpty ?? false);
    final url = Env.config.baseUrl.replaceFirst('api', 'url');
    String shareUrl = '$url/s/$type/$id';
    String shareMsg = '';

    try {
      if (appController.config == null) {
        SmartDialog.showLoading(msg: '加載中...');
        await appController.init();
      }

      final config = appController.config?.setupConfig;

      if (type == 0) {
        shareUrl = '$url/g/$id';
        shareMsg = config?.shareOrderText?.value ?? '';
      } else if (type == 3) {
        shareMsg = config?.askFriendText?.value ?? '';
      }

      shareMsg = shareMsg.replaceFirst('{0}', goodsName);

      // todo： 需要用goodsImageUrl，cardImageUrl，cardMsg 合成分享图片
      logger.i({
        'shareMsg': shareMsg,
        'goodsName': goodsName,
        'goodsImageUrl': goodsImageUrl,
        'cardImageUrl': cardImageUrl,
        'cardMsg': cardMsg,
      });

      final data = ShareData(
          shareUrl: shareUrl,
          shareMsg: shareMsg,
          goodsName: goodsName,
          imageUrl: goodsImageUrl,
          cardImageUrl: cardImageUrl,
          cardMsg: cardMsg);

      // app.showSharePoster(context: Get.context!, data: data,buttonText: '點擊立即贈予我');

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
                        data.method = ShareMethod.whatsApp;
                        onShare(data);
                      },
                    ),
                    ShareMenuItem(
                      name: 'Facebook Messenger',
                      img: 'icon_facebook.png',
                      onTap: () {
                        data.method = ShareMethod.facebook;
                        onShare(data);
                      },
                    ),
                    ShareMenuItem(
                      name: 'Twitter',
                      img: 'icon_twitter.jpg',
                      onTap: () {
                        data.method = ShareMethod.twitter;
                        onShare(data);
                      },
                    ),
                    ShareMenuItem(
                      name: 'Instagram',
                      img: 'icon_instagram.png',
                      onTap: () {
                        data.method = ShareMethod.instagram;
                        onShare(data);
                      },
                    ),
                    ShareMenuItem(
                      name: 'WeChat',
                      img: 'icon_wechat.png',
                      onTap: () async {
                        data.method = ShareMethod.weChat;
                        onShare(data);
                      },
                    ),
                    ShareMenuItem(
                      name: '短訊',
                      img: 'icon_message.png',
                      onTap: () {
                        data.method = ShareMethod.sms;
                        onShare(data);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } finally {
      SmartDialog.dismiss();
    }
  }
}
