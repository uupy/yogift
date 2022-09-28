import 'package:flutter/material.dart';

class AppAssetImage extends StatelessWidget {
  final String? img;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final bool noWrapper;
  final void Function()? onTap;

  const AppAssetImage({
    Key? key,
    this.img,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.fit,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.noWrapper = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: buildContainer(),
      );
    }
    return buildContainer();
  }

  Widget buildContainer() {
    final hasImg = img?.isNotEmpty ?? false;

    if (noWrapper) {
      return buildImg(width: width, height: height);
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: hasImg ? buildImg() : null,
    );
  }

  Widget buildImg({double? width, double? height}) {
    return Image(
      image: AssetImage('lib/assets/images/$img'),
      width: width,
      height: height,
      alignment: alignment,
      fit: fit ?? BoxFit.fitWidth,
      color: color,
      colorBlendMode: colorBlendMode,
    );
  }
}
