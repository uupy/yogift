import 'dart:typed_data';

import 'package:yo_gift/assets/fonts/iconfont.dart';
import 'package:yo_gift/widgets/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'app_video_player.dart';

class AppVideo extends StatefulWidget {
  final String url;
  final bool showCover;
  final Widget? coverCenterIcon;
  final BoxFit? coverFit;
  final Color? coverColor;
  final Function()? onTap;

  const AppVideo({
    Key? key,
    required this.url,
    this.showCover = true,
    this.coverCenterIcon,
    this.coverFit,
    this.coverColor,
    this.onTap,
  }) : super(key: key);

  @override
  _AppVideoState createState() => _AppVideoState();
}

class _AppVideoState extends State<AppVideo> {
  late bool isShowCover = widget.showCover;
  Uint8List? bytes;
  String? imageUrl;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    String url = widget.url;
    String urlPrefix = url.split('/').first;
    bool isRemote = urlPrefix.contains('http');

    if (isRemote) {
      imageUrl = '$url?x-oss-process=video/snapshot,t_1000,m_fast';
    } else if (url.isNotEmpty) {
      imageUrl = await VideoThumbnail.thumbnailFile(
        video: url,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 1000,
        quality: 95,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isShowCover) {
      return buildImage(imageUrl ?? '');
    }
    return AppVideoPlayer(url: widget.url);
  }

  Widget buildImage(String url) {
    return AppImage(
      onTap: widget.onTap,
      url: url,
      crop: false,
      color: widget.coverColor,
      fit: widget.coverFit,
      child: Center(
        child: widget.coverCenterIcon ??
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.35),
                borderRadius: BorderRadius.all(
                  Radius.circular(30.w),
                ),
              ),
              child: const Center(
                child: Icon(
                  IconFont.icon_play,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
      ),
    );
  }
}
