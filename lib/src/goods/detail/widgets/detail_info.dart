import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';

class GoodsDetailInfo extends StatelessWidget {
  const GoodsDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoodsDetailController>(
      id: 'GoodsDetailInfo',
      builder: (c) {
        final content = c.detail?.cDetail ?? '';

        return Html(
          data: content.replaceAll('<p><br/></p>', ''),
          // data: content,
          style: {
            'body': Style(
              margin: EdgeInsets.zero,
              lineHeight: LineHeight.number(1.5),
              fontSize: FontSize.medium,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
            ),
            'p': Style(
              margin: EdgeInsets.zero,
            ),
          },
          onLinkTap: (src, context, attrs, dom) {
            Get.toNamed('/pages/common/webview/index', parameters: {
              'src': src!,
            });
          },
        );
      },
    );
  }
}
