import 'package:flutter/material.dart';

class AppAssetImage extends StatelessWidget {
  final String? img;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final void Function()? onTap;

  const AppAssetImage({
    Key? key,
    this.img,
    this.width,
    this.height,
    this.margin,
    this.fit,
    this.alignment = Alignment.center,
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

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: hasImg
          ? Image(
              image: AssetImage('lib/assets/images/$img'),
              alignment: alignment,
              fit: fit ?? BoxFit.fitWidth,
            )
          : null,
    );
  }
}
