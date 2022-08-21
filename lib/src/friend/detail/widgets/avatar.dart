import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';

class FriendMsgAvatar extends StatelessWidget {
  final String url;
  final bool isSelf;

  const FriendMsgAvatar({Key? key, required this.url, this.isSelf = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry? margin = EdgeInsets.only(right: 20.w);

    if (isSelf) {
      margin = EdgeInsets.only(left: 20.w);
    }

    return AppImage(
      width: 44.w,
      height: 44.w,
      radius: 12.w,
      margin: margin,
      color: Colors.transparent,
      url: url,
    );
  }
}
