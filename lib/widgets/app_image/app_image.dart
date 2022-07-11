import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 图片
///
/// EdgeInsetsGeometry? [padding]
///
/// EdgeInsetsGeometry? [margin]
///
/// double? [width]
///
/// double? [height]
///
/// String? [url]
///
/// BorderRadiusGeometry? [borderRadius]
class AppImage extends StatelessWidget {
  final String? url;
  final Uint8List? bytes;
  final String? heroTag;
  final bool crop;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double? radius;
  final int? cropWidth;
  final int? cropHeight;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;
  final Color? color;
  final BoxConstraints? constraints;
  final Widget? child;
  final BoxFit? fit;
  final Function()? onTap;

  const AppImage({
    Key? key,
    this.url,
    this.bytes,
    this.heroTag,
    this.crop = true,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.radius,
    this.cropWidth = 350,
    this.cropHeight = 350,
    this.border,
    this.borderRadius,
    this.alignment,
    this.color,
    this.constraints,
    this.child,
    this.fit,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      if (bytes?.isNotEmpty ?? false) {
        final _image = Image.memory(bytes!);
        _image.image
            .resolve(const ImageConfiguration())
            .addListener(ImageStreamListener((ImageInfo info, bool _) {}));
        return buildGestureDetector(
          child: _image,
        );
      }
      return buildGestureDetector();
    }
    String urlPrefix = url!.split('/').first;
    bool isRemote = urlPrefix.contains('http');
    bool isAssets = urlPrefix.contains('assets');
    if (isRemote) {
      String imageUrl = url ?? '';
      if (crop) {
        String _cropSize = 'w_$cropWidth,h_$cropHeight';
        if (imageUrl.contains('?x-oss-process=')) {
          imageUrl = '$url,$_cropSize';
        } else {
          imageUrl = '$url?x-oss-process=image/resize,m_fill,$_cropSize';
        }
      }
      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) {
          return buildGestureDetector(
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
            child: child,
          );
        },
        placeholder: (context, url) {
          return buildGestureDetector(
            child: const Center(child: CupertinoActivityIndicator()),
          );
        },
        errorWidget: (context, url, error) {
          return buildGestureDetector(
            child: const Center(
              child: Icon(
                Icons.error,
                color: Colors.grey,
              ),
            ),
          );
        },
      );
    } else if (isAssets) {
      return buildGestureDetector(
        image: DecorationImage(
          image: ExactAssetImage(url!),
          fit: fit ?? BoxFit.cover,
        ),
        child: child,
      );
    }

    return buildGestureDetector(
      child: Image.file(
        File(url!),
        fit: fit ?? BoxFit.cover,
        width: double.maxFinite,
        height: double.maxFinite,
      ),
    );
  }

  Widget buildGestureDetector({
    DecorationImage? image,
    Widget? child,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: heroTag != null
          ? Hero(
              tag: heroTag!,
              child: buildWrapper(image: image, child: child),
            )
          : buildWrapper(image: image, child: child),
    );
  }

  Widget buildWrapper({
    DecorationImage? image,
    Widget? child,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? const Color(0xffF6F6F6),
        border: border,
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(radius ?? 4.r),
            ),
        image: image,
      ),
      child: child,
    );
  }
}
