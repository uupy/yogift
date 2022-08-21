import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/common/app.dart';
import 'package:yo_gift/models/friends_list.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_button.dart';
import 'package:yo_gift/widgets/app_input.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'invite_friend_controller.dart';

class InviteFriendPage extends StatefulWidget {
  const InviteFriendPage({Key? key}) : super(key: key);

  @override
  _InviteFriendPageState createState() => _InviteFriendPageState();
}

class _InviteFriendPageState extends State<InviteFriendPage> {
  final controller = Get.put(InviteFriendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('邀請朋友'),
      ),
      body: AppListView<IntroducerVo>(
        fetch: controller.queryList,
        controller: controller.listController,
        immediate: false,
        colCount: 1,
        prefix: GetBuilder<InviteFriendController>(
          id: 'InviteHeader',
          builder: (c) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 14.w),
                    child: Stack(
                      children: [
                        const AppAssetImage(
                          width: double.maxFinite,
                          img: 'bg_invite.png',
                        ),
                        Column(
                          children: [
                            SizedBox(height: 16.w),
                            Html(
                              data: c.config?.introduceGiftTitle?.value ?? '',
                              style: {
                                'p': Style(
                                  fontSize: FontSize(18.sp),
                                ),
                              },
                            ),
                            Text(
                              '您的專屬邀請鏈接',
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 0.5,
                              ),
                            ),
                            AppSimpleRow(
                              height: 32.w,
                              margin: EdgeInsets.only(
                                  left: 30.w, right: 30.w, top: 12.w),
                              padding: EdgeInsets.zero,
                              color: Colors.transparent,
                              expanded: AppInput(
                                hintText: c.inviteUrl,
                                backgroundColor: Colors.white,
                                maxLines: 1,
                                readOnly: true,
                                radius: Radius.circular(32.w),
                              ),
                              suffix: Container(
                                width: 76.w,
                                margin: EdgeInsets.only(left: 12.w),
                                child: AppButton(
                                  text: '複製',
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.white,
                                  style: const TextStyle(
                                    color: Color(0xff007aff),
                                  ),
                                  onPressed: () async {
                                    if (c.inviteUrl.isNotEmpty) {
                                      await Clipboard.setData(
                                          ClipboardData(text: c.inviteUrl));
                                      app.showToast('已複製');
                                    } else {
                                      Get.toNamed('/login')?.then((value) {
                                        if (value == true) {}
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Html(data: c.config?.introduceGiftTips?.value ?? ''),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      '成功邀請記錄',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        itemBuilder: (item, index, list) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Color.fromRGBO(230, 230, 230, 0.3),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRow('會員姓名：', item.nickName ?? ''),
                buildRow('會員編號：', item.id ?? ''),
                buildRow('加入日期：', item.createUserTime ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRow(String label, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
          ),
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ),
            TextSpan(
              text: content,
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
