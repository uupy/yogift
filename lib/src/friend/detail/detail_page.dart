import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yo_gift/models/friends_list.dart';
import 'package:yo_gift/widgets/app_asset_image.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_view.dart';
import 'package:yo_gift/widgets/app_simple_row.dart';

import 'detail_controller.dart';
import 'widgets/avatar.dart';
import 'widgets/goods_msg_container.dart';
import 'widgets/msg_container_arrow.dart';
import 'widgets/text_msg_container.dart';

class FriendDetailPage extends StatefulWidget {
  const FriendDetailPage({Key? key}) : super(key: key);

  @override
  _FriendDetailPageState createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends State<FriendDetailPage> {
  final controller = Get.put(FriendDetailController());

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.friendName ?? '好友消息'),
        actions: [
          AppSimpleRow(
            onTap: () {
              final parameters = Get.parameters.cast<String, String>();
              Get.toNamed('/pages/wish/index/index', parameters: parameters);
            },
            margin: EdgeInsets.only(right: 20.w),
            color: Colors.transparent,
            children: [
              AppAssetImage(
                width: 20.w,
                margin: EdgeInsets.only(right: 4.w),
                img: 'icon_wishlist.png',
              ),
              Text(
                '好友願望清單',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(0, 0, 0, 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
      body: AppListView<FriendMsgVo>(
        fetch: controller.queryList,
        controller: controller.listController,
        colCount: 1,
        reverse: true,
        reverseData: true,
        enablePullDown: false,
        enablePullUp: false,
        emptyPadding: EdgeInsets.fromLTRB(50.w, 60.w, 50.w, 0),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
        itemBuilder: (item, index, list) {
          final isSelf = item.operateByUserId == 1;
          Color backgroundColor = const Color(0xfff9ebb0);

          if (item.msgType == 1) {
            if (isSelf) {
              backgroundColor = const Color(0xffffe100);
            } else {
              backgroundColor = const Color(0xfff5f5f5);
            }
          } else {
            if (!isSelf) {
              backgroundColor = const Color(0xffffd7df);
            }
          }

          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.w),
                child: Center(
                  child: Text(
                    item.createTime ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.26),
                    ),
                  ),
                ),
              ),
              AppSimpleRow(
                margin: EdgeInsets.only(bottom: 20.w),
                mainAxisAlignment:
                    isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSelf) FriendMsgAvatar(url: item.friendHeadSrc ?? ''),
                  Stack(
                    children: [
                      MsgContainerArrow(
                        color: backgroundColor,
                        isSelf: isSelf,
                      ),
                      if (item.msgType == 1)
                        TextMsgContainer(
                          text: item.msgContent ?? '',
                          color: backgroundColor,
                        ),
                      if (item.msgType != 1)
                        GoodsMsgContainer(
                          image: item.cCoverImg ?? '',
                          content: item.msgContent ?? '',
                          color: backgroundColor,
                          onTap: () {
                            Get.toNamed('/pages/mine/order/detail/index',
                                parameters: {
                                  'id': '${item.msgEventId}',
                                });
                          },
                        ),
                    ],
                  ),
                  if (isSelf)
                    FriendMsgAvatar(
                      url: controller.user?.headSrc ?? '',
                      isSelf: true,
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
